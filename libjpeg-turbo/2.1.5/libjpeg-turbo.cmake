
function(libjpeg-turbo_Populate remote_url local_path os arch build_type)

    if(os STREQUAL "macos")

            set(compiler "appleclang15")

            # At the moment only relwithdebinfo
            # I don't think we need debug builds
            set(name "libjpeg-turbo_macos_${arch}_relwithdebinfo_${compiler}_os109")

            if (NOT EXISTS ${local_path}/${name}.7z)
                message(STATUS "[libjpeg-turbo] Populate: ${remote_url} to ${local_path} ${os} ${arch} ${build_type}")
                file(DOWNLOAD ${remote_url}/${name}.7z ${local_path}/${name}.7z)
                file(ARCHIVE_EXTRACT INPUT ${local_path}/${name}.7z DESTINATION ${local_path})
            endif()

            set(libjpeg-turbo_INCLUDE_DIRS ${local_path}/include)
            set(libjpeg-turbo_LIBRARIES
                ${local_path}/lib/libjpeg.8.2.2.dylib
                ${local_path}/lib/libturbojpeg.0.2.0.dylib
            )
            set(libjpeg-turbo_INSTALL_LIBRARIES
                ${local_path}/lib/libjpeg.8.2.2.dylib
                ${local_path}/lib/libjpeg.8.dylib
                ${local_path}/lib/libjpeg.dylib
                ${local_path}/lib/libturbojpeg.0.2.0.dylib
                ${local_path}/lib/libturbojpeg.0.dylib
                ${local_path}/lib/libturbojpeg.dylib
            )

    else()
        message(FATAL_ERROR "[libjpeg-turbo] Not supported os: ${os}")
    endif()

    if(NOT TARGET libjpeg-turbo::libjpeg-turbo)
       add_library(libjpeg-turbo::libjpeg-turbo INTERFACE IMPORTED GLOBAL)

       target_include_directories(libjpeg-turbo::libjpeg-turbo INTERFACE ${libjpeg-turbo_INCLUDE_DIRS} )
       target_link_libraries(libjpeg-turbo::libjpeg-turbo INTERFACE ${libjpeg-turbo_LIBRARIES} )
    endif()

    set_property(GLOBAL PROPERTY libjpeg-turbo_INCLUDE_DIRS ${libjpeg-turbo_INCLUDE_DIRS})
    set_property(GLOBAL PROPERTY libjpeg-turbo_LIBRARIES ${libjpeg-turbo_LIBRARIES})
    set_property(GLOBAL PROPERTY libjpeg-turbo_INSTALL_LIBRARIES ${libjpeg-turbo_INSTALL_LIBRARIES})

endfunction()

