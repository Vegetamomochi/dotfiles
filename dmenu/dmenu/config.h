/* ===== PYWAL COLORS ===== */

#include <X11/Xresource.h>

static char normbgcolor[16] = "#222222";
static char normfgcolor[16] = "#bbbbbb";
static char selbgcolor[16]  = "#444444";
static char selfgcolor[16]  = "#eeeeee";

static void
loadxrdb(void)
{
    XrmInitialize();
    char *resm = XResourceManagerString(dpy);
    if (!resm) return;

    XrmDatabase db = XrmGetStringDatabase(resm);
    XrmValue val;
    char *type;

    if (XrmGetResource(db, "*color0", "*", &type, &val))
        strncpy(normbgcolor, val.addr, sizeof(normbgcolor) - 1);

    if (XrmGetResource(db, "*color7", "*", &type, &val))
        strncpy(normfgcolor, val.addr, sizeof(normfgcolor) - 1);

    if (XrmGetResource(db, "*color1", "*", &type, &val))
        strncpy(selbgcolor, val.addr, sizeof(selbgcolor) - 1);

    if (XrmGetResource(db, "*color15", "*", &type, &val))
        strncpy(selfgcolor, val.addr, sizeof(selfgcolor) - 1);
}

static const char *colors[SchemeLast][2] = {
    [SchemeNorm] = { "#bbbbbb", "#222222" },
    [SchemeSel]  = { "#eeeeee", "#005577" },
};
