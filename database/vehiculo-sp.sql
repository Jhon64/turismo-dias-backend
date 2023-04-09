create function post_add_documentos(req json) returns json
    language plpgsql
as
$$
declare
    _id      int;
    jsonList json;
    result   json;
begin
    _id := req ->> 'id';
    jsonList := cast(req ->> 'files' as json);
    CREATE TEMPORARY TABLE if not exists temp_documentos
    (
        vehiculo   int,
        path         varchar,
        filename     varchar,
        originalname varchar
    );

    insert into temp_documentos select vehiculo,path,filename,originalname from json_populate_recordset (null::temp_documentos,jsonList) ;
    result := json_build_object('ID', _id, 'status', 'INSERT');
    
    
    insert into documentos(vehiculo_id,path, filename,  originalname) 
    select vehiculo  as "vehiculo_id",path,filename,originalname from temp_documentos temp;
drop table temp_documentos;
    return coalesce(result, '{}'::json);
end;
$$;

alter function post_add_documentos(json) owner to postgres;

---------------------------------------------------------------
create function post_add_vehiculo(req json) returns json
    language plpgsql
as
$$
declare
    _id                             int;
    _nombre                         varchar;
    _usuario_id                     int;
    _estado                         varchar;
    _deleted                        bool;
    _marca_id                       int;
    _modelo_id                      int;
    _tipo_vehiculo_id               int;
    _grupo_id                       int;
    _combustible_id                 int;
    _placa                          varchar;
    _anio                           int;
    _provincia_registro             varchar;
    _fotografia                     varchar;
    _propiedad                      varchar;
    _tarjeta_circulacion            varchar;
    _fecha_venc_tarjeta_circulacion int;
    _tarjeta_propiedad              varchar;
    _fecha_venc_tarjeta_propiedad   int;
    _color                          varchar;
    _motor                          varchar;
    _cilindros                      int;
    _cilindrada                     varchar;
    _vin_sin                     varchar;
    result                          json;
begin
    _id := req ->> 'id';
    _nombre := req ->> 'nombre';
    _usuario_id := req ->> 'usuarioID';
    _estado := cast(req ->> 'estado' as varchar);
    _deleted := coalesce(cast(req ->> 'deleted' as bool), false);
    _marca_id := cast(req ->> 'marcaID' as int);
    _modelo_id := cast(req ->> 'modeloID' as int);
    _tipo_vehiculo_id := cast(req ->> 'tipoVehiculoID' as int);
    _grupo_id := cast(req ->> 'grupoID' as int);
    _combustible_id := cast(req ->> 'combustibleID' as int);
    _combustible_id := cast(req ->> 'combustibleID' as int);
    _placa := req ->> 'placa';
    _anio := cast(req ->> 'anio' as int);
    _provincia_registro := req ->> 'provinciaRegistro';
    _fotografia := req ->> 'fotografia';
    _propiedad := req ->> 'propiedad';
    _tarjeta_circulacion := req ->> 'tarjetaCirculacion';
    _fecha_venc_tarjeta_circulacion := cast(req ->> 'fechaVencTarjetaCirculacion' as int);
    _fecha_venc_tarjeta_propiedad := cast(req ->> 'fechaVencTarjetaPropiedad' as int);
    _tarjeta_propiedad := req ->> 'tarjetaPropiedad';
    _color := req ->> 'color';
    _motor := req ->> 'motor';
    _cilindrada := req ->> 'cilindrada';
    _vin_sin := req ->> 'vinSin';
    _cilindros := cast(req ->> 'cilindros' as int);


    if _id is null then
        insert into vehiculo (nombre, placa, año, estado, provincia_registro, fotografia, propiedad,
                              tarjeta_circulacion, fech_venc_tarjeta_circulacion, tarjeta_propiedad,
                              fech_venc_tarjeta_propiedad, usuario_id, color, motor, cilindros, cilindrada,
                              combustible_id, grupo_id, tipo_vehiculo_id, marca_id, modelo_id,vin_sin)
        values (_nombre, _placa, _anio, _estado, _provincia_registro, _fotografia, _propiedad, _tarjeta_circulacion,
                _fecha_venc_tarjeta_circulacion,
                _tarjeta_propiedad, _fecha_venc_tarjeta_propiedad, _usuario_id, _color, _motor,
                _cilindros, _cilindrada, _combustible_id, _grupo_id, _tipo_vehiculo_id, _marca_id, _modelo_id,_vin_sin);
        _id := lastval();
        result := json_build_object('ID', _id, 'status', 'INSERT');
    else
        update vehiculo
        set estado=_estado,
            deleted=_deleted,
            usuario_id=_usuario_id,
            nombre=_nombre,
            placa=_placa,
            año=_anio,
            provincia_registro=_provincia_registro,
            fotografia=_fotografia,
            propiedad=_propiedad,
            tarjeta_circulacion=_tarjeta_circulacion,
            fech_venc_tarjeta_circulacion=_fecha_venc_tarjeta_circulacion,
            tarjeta_propiedad=_tarjeta_propiedad,
            fech_venc_tarjeta_propiedad=_fecha_venc_tarjeta_propiedad,
            color=_color,
            motor=_motor,
            cilindros=_cilindros,
            cilindrada=_cilindrada,
            combustible_id=_combustible_id,
            grupo_id=_grupo_id,
            tipo_vehiculo_id=_tipo_vehiculo_id,
            marca_id=_marca_id,
            modelo_id=_modelo_id,
            vin_sin=_vin_sin
        where id = _id;
        result := json_build_object('ID', _id, 'status', 'UPDATE');
    end if;
    return coalesce(result, '{}'::json);
end;
$$;

---------------------------------------
create function get_vehiculos(req json) returns json
    language plpgsql
as
$$
declare
    _id    int;
    result json;
begin
    _id := cast(req ->> 'id' as int);
    if _id is null then
        result := (select json_agg(t.*)
                   from (select v.id,v.nombre,v.vin_sin "vinSin",
                                v.estado,
                                v.deleted,
                                v.usuario_id                    "usuarioID",
                                v.marca_id                      "marcaID",
                                m.nombre  as                    marca,
                                v.modelo_id                     "modeloID",
                                m2.nombre                       modelo,
                                v.tipo_vehiculo_id              "tipoVehiculoID",
                                tv.nombre as                    "tipoVehiculo",
                                v.combustible_id                "combustibleID",
                                c.nombre  as                    combustible,
                                v.grupo_id                      "grupoID",
                                g.nombre                        "grupo",
                                motor,
                                v.tarjeta_propiedad             "tarjetaPropiedad",
                                v.color,
                                v.cilindros,
                                v.cilindrada,
                                v.placa,
                                v.tarjeta_circulacion           "tarjetaCirculacion",
                                v.fech_venc_tarjeta_propiedad   "fechaVencTarjetaPropiedad",
                                v.fech_venc_tarjeta_circulacion "fechaVencTarjetaCirculacion",
                                v.año                           "anio",
                                v.propiedad,
                                v.provincia_registro            "provinciaRegistro"
                         from vehiculo v
                                  left join marcas m on v.marca_id = m.id
                                  left join modelos m2 on m.id = m2.marca_id
                                  left join tipo_vehiculo tv on v.tipo_vehiculo_id = tv.id
                                  left join combustible c on v.combustible_id = c.id
                                  left join grupo g on v.grupo_id = g.id
                         where v.deleted = false) as t);
    else
        result := (select json_agg(t.*)
                   from (select v.id,v.nombre,v.vin_sin "vinSin",
                                v.estado,
                                v.deleted,
                                v.usuario_id                    "usuarioID",
                                v.marca_id                      "marcaID",
                                m.nombre  as                    marca,
                                v.modelo_id                     "modeloID",
                                m2.nombre                       modelo,
                                v.tipo_vehiculo_id              "tipoVehiculoID",
                                tv.nombre as                    "tipoVehiculo",
                                v.combustible_id                "combustibleID",
                                c.nombre  as                    combustible,
                                v.grupo_id                      "grupoID",
                                g.nombre                        "grupo",
                                motor,
                                v.tarjeta_propiedad             "tarjetaPropiedad",
                                v.color,
                                v.cilindros,
                                v.cilindrada,
                                v.placa,
                                v.tarjeta_circulacion           "tarjetaCirculacion",
                                v.fech_venc_tarjeta_propiedad   "fechaVencTarjetaPropiedad",
                                v.fech_venc_tarjeta_circulacion "fechaVencTarjetaCirculacion",
                                v.año                           "anio",
                                v.propiedad,
                                v.provincia_registro            "provinciaRegistro"
                         from vehiculo v
                                  left join marcas m on v.marca_id = m.id
                                  left join modelos m2 on m.id = m2.marca_id
                                  left join tipo_vehiculo tv on v.tipo_vehiculo_id = tv.id
                                  left join combustible c on v.combustible_id = c.id
                                  left join grupo g on v.grupo_id = g.id
                         where v.deleted = false and v.id=_id) as t);
    end if;

    return coalesce(result, '[]'::json);
end ;
$$;





