
function(libpng_Populate remote_url local_path os arch build_type)

    if(os STREQUAL "macos")

            set(compiler "appleclang15")

            # At the moment only relwithdebinfo
            # I don't think we need debug builds
            set(name "libpng_macos_${arch}_relwithdebinfo_${compiler}_os109")

            if (NOT EXISTS ${local_path}/${name}.7z)
                message(STATUS "[libpng] Populate: ${remote_url} to ${local_path} ${os} ${arch} ${build_type}")
                file(DOWNLOAD ${remote_url}/${name}.7z ${local_path}/${name}.7z)
                file(ARCHIVE_EXTRACT INPUT ${local_path}/${name}.7z DESTINATION ${local_path})
            endif()

            set(libpng_INCLUDE_DIRS ${local_path}/include)
            set(libpng_LIBRARIES
                ${local_path}/lib/libpng16.16.39.0.dylib
            )
            set(libpng_INSTALL_LIBRARIES
                ${local_path}/lib/libpng16.16.39.0.dylib
                ${local_path}/lib/libpng16.16.dylib
                ${local_path}/lib/libpng16.dylib
                ${local_path}/lib/libpng.dylib
            )

    else()
        message(FATAL_ERROR "[libpng] Not supported os: ${os}")
    endif()

    if(NOT TARGET libpng::libpng)
       add_library(libpng::libpng INTERFACE IMPORTED GLOBAL)

       target_include_directories(libpng::libpng INTERFACE ${libpng_INCLUDE_DIRS} )
       target_link_libraries(libpng::libpng INTERFACE ${libpng_LIBRARIES} )
    endif()

    set_property(GLOBAL PROPERTY libpng_INCLUDE_DIRS ${libpng_INCLUDE_DIRS})
    set_property(GLOBAL PROPERTY libpng_LIBRARIES ${libpng_LIBRARIES})
    set_property(GLOBAL PROPERTY libpng_INSTALL_LIBRARIES ${libpng_INSTALL_LIBRARIES})

endfunction()

