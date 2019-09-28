if(IS_ABSOLUTE "${INSTALL_LIBEXECDIR}")
    set(ABSOLUTE_LIBEXECDIR "${INSTALL_LIBEXECDIR}")
else()
    set(ABSOLUTE_LIBEXECDIR "${CMAKE_INSTALL_PREFIX}/${INSTALL_LIBEXECDIR}")
endif()
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
