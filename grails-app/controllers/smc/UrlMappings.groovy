package smc

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/dashboard/index")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
