
function(expat_Populate remote_url local_path os arch build_type)

    if (os STREQUAL "linux")

        set(compiler "gcc10")

        set(name "linux_${arch}")
        # if (build_type STREQUAL "debug")
        #     set(name "${name}_debug_${compiler}")
        # else()
            set(name "${name}_relwithdebinfo_${compiler}")
        # endif()

        if (NOT EXISTS ${local_path}/${name}.7z)
            message(STATUS "[expat] Populate: ${remote_url} to ${local_path} ${os} ${arch} ${build_type}")
            file(DOWNLOAD ${remote_url}/${name}.7z ${local_path}/${name}.7z)
            file(ARCHIVE_EXTRACT INPUT ${local_path}/${name}.7z DESTINATION ${local_path})
        endif()

        set(expat_INCLUDE_DIRS ${local_path}/include)
        set(expat_LIBRARIES ${local_path}/lib/libexpat.so)

        set_property(GLOBAL PROPERTY expat_INCLUDE_DIRS ${expat_INCLUDE_DIRS})
        set_property(GLOBAL PROPERTY expat_LIBRARIES ${expat_LIBRARIES})

    else()
        message(FATAL_ERROR "[expat] Not supported os: ${os}")
    endif()


    set(expat_POPULATED ON PARENT_SCOPE)


    if(NOT TARGET expat::expat)
       add_library(expat::expat INTERFACE IMPORTED GLOBAL)

       target_include_directories(expat::expat INTERFACE ${expat_INCLUDE_DIRS} )
       target_link_libraries(expat::expat INTERFACE ${expat_LIBRARIES} )
    endif()

endfunction()

