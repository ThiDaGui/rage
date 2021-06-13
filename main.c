#include <argp.h>
#include <stdlib.h>
#include <ncurses.h>
#include <math.h>
#include <err.h>
#include "src/parser.h"
#include "src/projection.h"
#include "src/win.h"

float   rect_avg(const int img[], int width, int height,
            int startX, int startY, int rect_width, int rect_height);

void    image2ascii(WINDOW *win, const int img[], int width, int height,
            int char_width, int char_height);

void    init_camera(camera_t *cam, float fov, size_t width, size_t height,
            vector3_t *pos, vector3_t *uz);

void    draw_status_window(WINDOW *status_win);

void    redraw(WINDOW *win, camera_t *camera, vector3_t *light, obj_t *obj,
            int image[], float theta, float phi, float camera_pos_norm);

void    clear_image_buffer(int image[], size_t len);

/* Argparser */
#define ARGP_FILENAME_KEY 'f'
#define ARGP_FOV_KEY 800
#define ARGP_ROTR_KEY 'r'

/* Initial configuration */
#define DEFAULT_FOV         30.0                    // Default value of the fov
#define CHAR_WIDTH          3                       // Pixels for char width
#define CHAR_HEIGHT         6                       // Pixels for char height
#define ROTATION_STEP       (0.05f * M_PI)          // Rotation step
#define ZOOM_STEP           1.0f                    // Zoom step value
#define INITIAL_THETA       0.0f                    // Initial value of theta angle
#define INITIAL_PHI         0.0f                    // Initial value of phi angle
#define INITIAL_POS_NORM    25.0f                   // Initial value of camera_pos_norm
#define MIN_ZOOM_DISTANCE   4.0f                    // Lower limit of the zoom
#define MAX_ZOOM_DISTANCE   150.0f                  // Upper limit of the zoom
#define MIN_Z_ROTATION      (-0.45f * M_PI)         // Lower limit of the rotation at z coordinates
#define MAX_Z_ROTATION      (0.45f * M_PI)          // Upper limit of the rotation z coordinates

/* Keys */
#define RAGE_EXIT_KEY 'q'
#define RAGE_LEFT_KEY 'a'
#define RAGE_RIGHT_KEY 'd'
#define RAGE_UP_KEY 'w'
#define RAGE_DOWN_KEY 's'
#define RAGE_ZOOM_IN_KEY 'r'
#define RAGE_ZOOM_OUT_KEY 'f'
#define RAGE_RESET_KEY '1'

typedef struct args_s {
    char    *filename;
    float   fov;
} args_t;

/* Program documentation */
static char doc[] = "Convert an input .obj model into ASCII art.";

/* Usage documentation */
static char args_doc[] = "";

static struct argp_option options[] = {
    {"filename", ARGP_FILENAME_KEY, "FILE", 0, "Image to transform into ASCII", 0},
    {"fov", ARGP_FOV_KEY, "float", 0, "Field of view of the camera", 0},
    {0},
};

int     parse_opt(int key, char *arg, struct argp_state *state) {
    args_t *args = (args_t *) state->input;

    switch (key) {
        case ARGP_FILENAME_KEY:
            args->filename = arg;
            break;
        case ARGP_FOV_KEY:
            errno = 0;

            char    *end_ptr;
            float   val = strtof(arg, &end_ptr);

            if (errno == ERANGE && val == HUGE_VALF)
                argp_error(state, "impossible to parse field of view. Float overflow");
            if ((errno != 0 && val == 0) || end_ptr == arg)
                argp_error(state, "impossible to parse field of view. Invalid argument");
            if (val <= 0)
                argp_error(state, "field of view cannot be negative");

            args->fov = val;
            break;
        case ARGP_KEY_END:
            /* Arguments validation */
            if (args->filename == NULL)
                argp_error(state, "filename argument required");
            break;
        default:
            return ARGP_ERR_UNKNOWN;
    }

    return 0;
}

static struct argp argp = {options, parse_opt, args_doc, doc, 0, 0, 0};

int     main(int argc, char *argv[]) {
    args_t args = {NULL, DEFAULT_FOV};
    argp_parse(&argp, argc, argv, 0, 0, &args);

    /* Try load model */
    obj_t *obj = obj_init();
    if (parse_obj_file(obj, args.filename) < 0) {
        errx(1, "Error while parsing the object %s", args.filename);
    }

    /* NCurses Window */
    WINDOW *win, *status_win;

    /* Initialization */
    initscr();                  // Start curses mode
    cbreak();                   // No wait for \n
    noecho();                   // Don't echo input
    curs_set(0);                // Don't show cursor

    win = window_create(COLS, LINES - 2, 0, 0);
    status_win = window_create(COLS, 2, 0, LINES - 2);

    /* Lightning init */
    vector3_t   light = VECTOR3_INIT;
    vector3_set(&light, 0, 255, 255);

    /* Camera init */
    camera_t    camera;
    vector3_t   camera_pos = VECTOR3_INIT;
    vector3_t   camera_uz = VECTOR3_INIT;

    init_camera(&camera, args.fov, (COLS - 1) * CHAR_WIDTH,
        (LINES - 2) * CHAR_HEIGHT, &camera_pos, &camera_uz);

    float theta = INITIAL_THETA;
    float phi = INITIAL_PHI;
    float camera_pos_norm = INITIAL_POS_NORM;

    /* Initialize image */
    int     image[camera.height * camera.width];
    redraw(win, &camera, &light, obj, image, theta, phi, camera_pos_norm);

    /* Draw status bar */
    draw_status_window(status_win);

    int ch;
    while (OBJ_TRUE) {
        ch = wgetch(win);
        if (ch == RAGE_EXIT_KEY)
            break;

        switch (ch) {
            case RAGE_ZOOM_IN_KEY:
                /* Zoom in */
                if (camera_pos_norm > MIN_ZOOM_DISTANCE) {
                    camera_pos_norm -= ZOOM_STEP;
                }
                break;
            case RAGE_ZOOM_OUT_KEY:
                /* Zoom out */
                if (camera_pos_norm <= MAX_ZOOM_DISTANCE) {
                    camera_pos_norm += ZOOM_STEP;
                }
                break;
            case RAGE_LEFT_KEY:
                /* Rotate camera to left */
                theta -= ROTATION_STEP;
                break;
            case RAGE_RIGHT_KEY:
                /* Rotate camera to right */
                theta += ROTATION_STEP;
                break;
            case RAGE_UP_KEY:
                /* Rotate camera up */
                if (phi + ROTATION_STEP < MAX_Z_ROTATION) {
                    phi += ROTATION_STEP;
                }
                break;
            case RAGE_DOWN_KEY:
                /* Rotate camera down */
                if (phi - ROTATION_STEP > MIN_Z_ROTATION) {
                    phi -= ROTATION_STEP;
                }
                break;
            case RAGE_RESET_KEY:
                theta = INITIAL_THETA;
                phi = INITIAL_PHI;
                camera_pos_norm = INITIAL_POS_NORM;
                break;
            default:
                /* Do nothing */
                continue;
        }
        /* Draw image */
        redraw(win, &camera, &light, obj, image, theta, phi, camera_pos_norm);
    }

    /* Window Cleanup */
    window_delete(win);
    window_delete(status_win);
    endwin();                   // End curses mode

    return EXIT_SUCCESS;
}

static char ascii_chars[] = {
    ' ', '.', '\'', '`', '^', '"', ',', ':', ';',
    'I', 'l', '!', 'i', '>', '<', '~', '+', '_', '-', '?', ']', '[', '}', '{',
    '1', ')', '(', '|', '\\', '/', 't', 'f', 'j', 'r', 'x', 'n', 'u', 'v', 'c',
    'z', 'X', 'Y', 'U', 'J', 'C', 'L', 'Q', '0', 'O', 'Z', 'm', 'w', 'q', 'p',
    'd', 'b', 'k', 'h', 'a', 'o', '*', '#', 'M', 'W', '&', '8', '%', 'B', '@',
    '$'
};

float   rect_avg(const int img[], int width, int height, int startX,
            int startY, int rect_width, int rect_height) {
    float sum = 0, count = 0;

    for (int i = 0; i < rect_width && startX + i < width; ++i) {
        for (int j = 0; j < rect_height && startY + j < height; ++j) {
            sum += (float) img[(startY + j) * width + (startX + i)];
            count += 1;
        }
    }
    if (count == 0)
        return 0;

    return sum / count;
}

void    image2ascii(WINDOW *win, const int img[], int width, int height,
            int char_width, int char_height) {
    float val;
    for (int i = 0; i < height; i += char_height) {
        for (int j = 0; j < width; j += char_width) {
            val = rect_avg(img, width, height, j, i, char_width, char_height) / 255;
            waddch(win, ascii_chars[(int) (ceilf(val * 69))]);
        }
        waddch(win, '\n');
    }
    wrefresh(win);
}

void    init_camera(camera_t *cam, float fov, size_t width, size_t height,
            vector3_t *pos, vector3_t *uz) {
    cam->fov = fov;
    cam->width = width;
    cam->height = height;
    cam->position = pos;
    cam->look_at = uz;
}

void    redraw(WINDOW *win, camera_t *camera, vector3_t *light, obj_t *obj,
            int image[], float theta, float phi, float camera_pos_norm) {
    vector3_set(camera->look_at, cosf(-phi) * cosf(M_PI + theta),
        cosf(-phi) * sinf(M_PI + theta), sinf(-phi));
    vector3_set(camera->position, camera_pos_norm * cosf(phi) * cosf(theta),
        camera_pos_norm * cosf(phi) * sinf(theta), camera_pos_norm * sinf(phi));

    clear_image_buffer(image, camera->width * camera->height);
    projection(obj, camera, light, image);      // Update image

    wclear(win);
    image2ascii(win, image, camera->width, camera->height, CHAR_WIDTH, CHAR_HEIGHT);
}

void    clear_image_buffer(int image[], size_t len) {
    for (size_t i = 0; i < len; i++) {
        image[i] = 0;
    }
}

void    draw_status_window(WINDOW *status_win) {
    whline(status_win, ACS_HLINE, COLS);    // Horizontal line
    wattron(status_win, A_BOLD);
    {
        wmove(status_win, 1, 0);
        wprintw(status_win, " [%c][%c][%c][%c]Rotate [%c][%c]Zoom [%c]Reset [%c]Quit",
            RAGE_LEFT_KEY, RAGE_DOWN_KEY, RAGE_RIGHT_KEY, RAGE_UP_KEY,
            RAGE_ZOOM_IN_KEY, RAGE_ZOOM_OUT_KEY, RAGE_RESET_KEY, RAGE_EXIT_KEY);
    }
    wattroff(status_win, A_BOLD);
    wrefresh(status_win);
}
