
function(portaudio_Populate remote_url local_path os arch build_type)

    if (os STREQUAL "linux")

        set(compiler "gcc10")

        set(name "linux_${arch}")
        # if (build_type STREQUAL "debug")
        #     set(name "${name}_debug_${compiler}")
        # else()
            set(name "${name}_relwithdebinfo_${compiler}")
        # endif()

        if (NOT EXISTS ${local_path}/${name}.7z)
            message(STATUS "[portaudio] Populate: ${remote_url} to ${local_path} ${os} ${arch} ${build_type}")
            file(DOWNLOAD ${remote_url}/${name}.7z ${local_path}/${name}.7z)
            file(ARCHIVE_EXTRACT INPUT ${local_path}/${name}.7z DESTINATION ${local_path})
        endif()

        set(portaudio_INCLUDE_DIRS ${local_path}/include)
        set(portaudio_LIBRARIES ${local_path}/lib/libportaudio.so)

        set_property(GLOBAL PROPERTY portaudio_INCLUDE_DIRS ${portaudio_INCLUDE_DIRS})
        set_property(GLOBAL PROPERTY portaudio_LIBRARIES ${portaudio_LIBRARIES})

    else()
        message(FATAL_ERROR "[portaudio] Not supported os: ${os}")
    endif()


    set(portaudio_POPULATED ON PARENT_SCOPE)


    if(NOT TARGET portaudio::portaudio)
       add_library(portaudio::portaudio INTERFACE IMPORTED GLOBAL)

       target_include_directories(portaudio::portaudio INTERFACE ${portaudio_INCLUDE_DIRS} )
       target_link_libraries(portaudio::portaudio INTERFACE ${portaudio_LIBRARIES} )
    endif()

endfunction()

