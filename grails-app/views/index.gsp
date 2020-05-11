<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>INDEX</title>
</head>
<body>
<div class="col-lg-8 col-md-12">

    <div class="card card-outline-success">
        <div class="card-header pb-0 pb-lg-0">
            <h5 class="card-title text-white"><i class="fa fa-pencil-alt"></i>&nbsp;Registar ${entity}</h5>
        </div>

        <div class="card-body">
            <p class="desc">create</p>
        </div>

        <div class="card-footer">
            <button class="btn btn-sm btn-outline-secondary waves-effect waves-light"><i class="fa fa-times"></i>&nbsp;Cancelar</button>
            <button class="btn btn-sm btn-outline-success float-right waves-effect waves-light"><i class="fa fa-save"></i>&nbsp;Salvar</button>
        </div>
    </div>

    <div class="card card-outline-success">
        <div class="card-header pb-0 pb-lg-0">
            <h5 class="card-title text-white"><i class="fa fa-eye"></i>&nbsp;${entity}
                <button class="btn btn-xs btn-outline-light float-right waves-effect waves-light"><i class="fa fa-edit"></i>&nbsp;${entity}</button>
            </h5>
        </div>

        <div class="card-body">
            <p class="desc">show</p>
        </div>
    </div>

    <div class="card card-outline-success">
        <div class="card-header pb-0 pb-lg-0">
            <h5 class="card-title text-white"><i class="fa fa-edit"></i>&nbsp;Editar ${entity}</h5>
        </div>

        <div class="card-body">
            <p class="desc">edit</p>
        </div>

        <div class="card-footer">
            <button class="btn btn-sm btn-outline-secondary waves-effect waves-light"><i class="fa fa-times"></i>&nbsp;Cancelar</button>
            <button class="btn btn-sm btn-outline-success float-right waves-effect waves-light"><i class="fa fa-save"></i>&nbsp;Actualizar</button>
        </div>
    </div>

    <div class="card card-outline-success">
        <div class="card-header pb-0 pb-lg-0">
            <h5 class="card-title text-white"><i class="fa fa-list"></i>&nbsp;Listar ${entity}s
                <button class="btn btn-xs btn-outline-light float-right waves-effect waves-light"><i class="fa fa-plus"></i>&nbsp;${entity}</button>
            </h5>
        </div>

        <div class="card-body">
            <p class="desc">index</p>
        </div>
    </div>
</div>

</body>
</html>
