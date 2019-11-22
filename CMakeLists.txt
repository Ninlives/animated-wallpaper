project (animated-wallpaper)
cmake_minimum_required (VERSION 2.8)
list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/)

set (RELEASE_NAME "hummingbird")
set (VERSION "0.1")
set (VERSION_INFO "Release")
set (ARCHIVE_NAME animated-wallpaper-${VERSION})

find_package(PkgConfig)
pkg_check_modules(DEPS REQUIRED gtk+-3.0 glib-2.0>=2.38 clutter-gtk-1.0 clutter-1.0 clutter-gst-3.0)
add_definitions(${DEPS_CFLAGS})

link_directories(${DEPS_LIBRARY_DIRS})
find_package(Vala REQUIRED)
include(ValaVersion)
include(ValaPrecompile)

find_package(Vala REQUIRED)

ensure_vala_version("0.16" MINIMUM)
vala_precompile(VALA_C
    src/Main.vala
    src/Playable.vala

PACKAGES
    gtk+-3.0
    glib-2.0
    clutter-gtk-1.0
    clutter-1.0
    clutter-gst-3.0
    gstreamer-1.0
OPTIONS
    --vapidir=${CMAKE_CURRENT_SOURCE_DIR}/vapi/
   	--disable-warnings

)
add_definitions(${CFLAGS} -Wall -Winit-self -Wwrite-strings -Wunreachable-code -Wstrict-prototypes)
add_executable(animated-wallpaper ${VALA_C})
target_link_libraries(animated-wallpaper ${DEPS_LIBRARIES} -lm)

install(TARGETS animated-wallpaper RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
