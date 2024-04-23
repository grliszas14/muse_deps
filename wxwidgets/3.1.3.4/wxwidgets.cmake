
function(wxwidgets_Populate remote_url local_path os arch build_type)

    if (os STREQUAL "linux")

        set(compiler "gcc11")

        # At the moment only relwithdebinfo
        # I don't think we need debug builds
        set(name "linux_${arch}_relwithdebinfo_${compiler}")

        if (NOT EXISTS ${local_path}/${name}.7z)
            message(STATUS "[wxwidgets] Populate: ${remote_url} to ${local_path} ${os} ${arch} ${build_type}")
            file(DOWNLOAD ${remote_url}/${name}.7z ${local_path}/${name}.7z)
            file(ARCHIVE_EXTRACT INPUT ${local_path}/${name}.7z DESTINATION ${local_path})
        endif()

        set(wxwidgets_INCLUDE_DIRS
            ${local_path}/include
            ${local_path}/include/wx-3.1
        )

        set(wxwidgets_LIBRARIES
            ${local_path}/lib/libwx_baseu-3.1.so
            ${local_path}/lib/libwx_baseu_net-3.1.so
            ${local_path}/lib/libwx_baseu_xml-3.1.so
            ${local_path}/lib/libwx_gtk2u_adv-3.1.so
            ${local_path}/lib/libwx_gtk2u_aui-3.1.so
            ${local_path}/lib/libwx_gtk2u_core-3.1.so
            ${local_path}/lib/libwx_gtk2u_html-3.1.so
            ${local_path}/lib/libwx_gtk2u_qa-3.1.so
            ${local_path}/lib/libwx_gtk2u_xrc-3.1.so
        )

        set_property(GLOBAL PROPERTY wxwidgets_INCLUDE_DIRS ${wxwidgets_INCLUDE_DIRS})
        set_property(GLOBAL PROPERTY wxwidgets_LIBRARIES ${wxwidgets_LIBRARIES})

    elseif(os STREQUAL "macos")

        set(compiler "appleclang15")

        # At the moment only relwithdebinfo
        # I don't think we need debug builds
        set(name "macos_${arch}_relwithdebinfo_${compiler}_os109")

        if (NOT EXISTS ${local_path}/${name}.7z)
            message(STATUS "[wxwidgets] Populate: ${remote_url}/${name} to ${local_path} ${os} ${arch} ${build_type}")
            file(DOWNLOAD ${remote_url}/${name}.7z ${local_path}/${name}.7z)
            file(ARCHIVE_EXTRACT INPUT ${local_path}/${name}.7z DESTINATION ${local_path})
        endif()

        set(wxwidgets_INCLUDE_DIRS
            ${local_path}/include
            ${local_path}/include/wx-3.1
        )

        set(wxwidgets_LIBRARIES
            ${local_path}/lib/libwx_baseu-3.1.dylib
            ${local_path}/lib/libwx_baseu_net-3.1.dylib
            ${local_path}/lib/libwx_baseu_xml-3.1.dylib
            ${local_path}/lib/libwx_osx_cocoau_adv-3.1.dylib
            ${local_path}/lib/libwx_osx_cocoau_aui-3.1.dylib
            ${local_path}/lib/libwx_osx_cocoau_core-3.1.dylib
            ${local_path}/lib/libwx_osx_cocoau_html-3.1.dylib
            ${local_path}/lib/libwx_osx_cocoau_qa-3.1.dylib
            ${local_path}/lib/libwx_osx_cocoau_xrc-3.1.dylib
        )

        set_property(GLOBAL PROPERTY wxwidgets_INCLUDE_DIRS ${wxwidgets_INCLUDE_DIRS})
        set_property(GLOBAL PROPERTY wxwidgets_LIBRARIES ${wxwidgets_LIBRARIES})

    else()
        message(FATAL_ERROR "[wxwidgets] Not supported os: ${os}")
    endif()

    add_library(wxwidgets::wxwidgets INTERFACE IMPORTED GLOBAL)
    target_include_directories(wxwidgets::wxwidgets INTERFACE ${wxwidgets_INCLUDE_DIRS})
    target_link_libraries(wxwidgets::wxwidgets INTERFACE ${wxwidgets_LIBRARIES})

endfunction()

