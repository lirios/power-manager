file(GLOB _files "*.xml")
install(FILES ${_files} DESTINATION "${INSTALL_DATADIR}/glib-2.0/schemas")
