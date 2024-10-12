set(LIBEXECDIR "${KDE_INSTALL_LIBEXECDIR}")
configure_file(
    "liri-daemon-power.service.in"
    "${CMAKE_CURRENT_BINARY_DIR}/liri-daemon-power.service"
    @ONLY
)

install(
    FILES
        "${CMAKE_CURRENT_BINARY_DIR}/liri-daemon-power.service"
    DESTINATION
        "${INSTALL_SYSTEMDUSERUNITDIR}"
)
