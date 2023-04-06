PGDMP     8    ;                {            turismodiazdb %   12.14 (Ubuntu 12.14-0ubuntu0.20.04.1) %   12.14 (Ubuntu 12.14-0ubuntu0.20.04.1) �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16385    turismodiazdb    DATABASE        CREATE DATABASE turismodiazdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'es_PE.UTF-8' LC_CTYPE = 'es_PE.UTF-8';
    DROP DATABASE turismodiazdb;
                postgres    false                        2615    16610 	   seguridad    SCHEMA        CREATE SCHEMA seguridad;
    DROP SCHEMA seguridad;
                postgres    false            �            1255    16908    get_combustible(json)    FUNCTION     �  CREATE FUNCTION public.get_combustible(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
    _id    int;
    result json;
begin
    -- 
    result := (select json_agg(t.*)
               from (select id, estado, deleted, usuario_id "usuarioID", nombre
                     from combustible
                     where deleted = false ORDER BY id desc ) as t);
    return coalesce(result, '[]'::json);
end;
$$;
 0   DROP FUNCTION public.get_combustible(req json);
       public          postgres    false            �            1255    16910    get_grupos(json)    FUNCTION     �  CREATE FUNCTION public.get_grupos(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
    _id    int;
    result json;
begin
    --
    result := (select json_agg(t.*)
               from (select id, estado, deleted, usuario_id "usuarioID", nombre
                     from grupo
                     where deleted = false order by id desc ) as t);
    return coalesce(result, '[]'::json);
end;
$$;
 +   DROP FUNCTION public.get_grupos(req json);
       public          postgres    false            �            1255    16912    get_marcas(json)    FUNCTION     �  CREATE FUNCTION public.get_marcas(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
    _id    int;
    result json;
begin
    --
    result := (select json_agg(t.*)
               from (select id, estado, deleted, usuario_id "usuarioID", nombre,slug
                     from marcas
                     where deleted = false) as t);
    return coalesce(result, '[]'::json);
end;
$$;
 +   DROP FUNCTION public.get_marcas(req json);
       public          postgres    false            �            1255    16914    get_modelos(json)    FUNCTION       CREATE FUNCTION public.get_modelos(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
    _id    int;
    result json;
begin
    --
    result := (select json_agg(t.*)
               from (select m.id, m.estado, m.deleted, m.usuario_id "usuarioID", m.nombre,m.slug,
                            marca_id "marcaID",m2.nombre as marca
                     from modelos m left join marcas m2 on m2.id = m.marca_id
                     where m.deleted = false) as t);
    return coalesce(result, '[]'::json);
end;
$$;
 ,   DROP FUNCTION public.get_modelos(req json);
       public          postgres    false            �            1255    16919    get_personas(json)    FUNCTION     I  CREATE FUNCTION public.get_personas(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
    _id    int;
    result json;
begin
    --
    result := (select json_agg(t.*)
               from (select id, estado, deleted, usuario_id "usuarioID", nombre,
                            paterno,materno,full_name as "fullname",
                            dni,direccion,celular,fecha_nacimiento "fechaNacimiento",
                            sexo
                     from persona
                     where deleted = false) as t);
    return coalesce(result, '[]'::json);
end ;
$$;
 -   DROP FUNCTION public.get_personas(req json);
       public          postgres    false            �            1255    16916    get_tipo_vehiculos(json)    FUNCTION     �  CREATE FUNCTION public.get_tipo_vehiculos(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
    _id    int;
    result json;
begin
    --
    result := (select json_agg(t.*)
               from (select id, estado,deleted, usuario_id "usuarioID", nombre,slug
                     from tipo_vehiculo
                     where deleted = false) as t);
    return coalesce(result, '[]'::json);
end;
$$;
 3   DROP FUNCTION public.get_tipo_vehiculos(req json);
       public          postgres    false                       1255    16923    get_vehiculos(json)    FUNCTION       CREATE FUNCTION public.get_vehiculos(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
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
 .   DROP FUNCTION public.get_vehiculos(req json);
       public          postgres    false            �            1255    16909    post_add_combustible(json)    FUNCTION     �  CREATE FUNCTION public.post_add_combustible(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
    _id         int;
    _nombre     varchar;
    _usuario_id int;
    _estado     bool;
    _deleted    bool;
    result      json;
begin
    _id := req ->> 'id';
    _nombre := req ->> 'nombre';
    _usuario_id := req ->> 'usuarioID';
    _estado := coalesce(cast(req ->> 'estado' as bool), true);
    _deleted := coalesce(cast(req ->> 'deleted' as bool) , false);
    if _id is null then
        insert into combustible (estado, deleted, usuario_id, nombre)
        values (_estado, _deleted, _usuario_id, _nombre);
        _id:=lastval();
        result:=json_build_object('ID',_id,'status','INSERT');
    else
        update combustible
        set nombre=_nombre,
            estado=_estado,
            deleted=_deleted,
            usuario_id=_usuario_id
        where id = _id;
        result:=json_build_object('ID',_id,'status','UPDATE');
    end if;
    return coalesce(result, '{}'::json);
end;
$$;
 5   DROP FUNCTION public.post_add_combustible(req json);
       public          postgres    false            �            1255    16911    post_add_grupo(json)    FUNCTION     �  CREATE FUNCTION public.post_add_grupo(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
    _id         int;
    _nombre     varchar;
    _usuario_id int;
    _estado     bool;
    _deleted    bool;
    result      json;
begin
    _id := req ->> 'id';
    _nombre := req ->> 'nombre';
    _usuario_id := req ->> 'usuarioID';
    _estado := coalesce(cast(req ->> 'estado' as bool), true);
    _deleted := coalesce(cast(req ->> 'deleted' as bool) , false);
    if _id is null then
        insert into grupo (estado, deleted, usuario_id, nombre)
        values (_estado, _deleted, _usuario_id, _nombre);
        _id:=lastval();
        result:=json_build_object('ID',_id,'status','INSERT');
    else
        update grupo
        set nombre=_nombre,
            estado=_estado,
            deleted=_deleted,
            usuario_id=_usuario_id
        where id = _id;
        result:=json_build_object('ID',_id,'status','UPDATE');
    end if;
    return coalesce(result, '{}'::json);
end;
$$;
 /   DROP FUNCTION public.post_add_grupo(req json);
       public          postgres    false            �            1255    16913    post_add_marcas(json)    FUNCTION     B  CREATE FUNCTION public.post_add_marcas(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
    _id         int;
    _nombre     varchar;
    _slug     varchar;
    _usuario_id int;
    _estado     bool;
    _deleted    bool;
    result      json;
begin
    _id := req ->> 'id';
    _nombre := req ->> 'nombre';
    _slug := req ->> 'slug';
    _usuario_id := req ->> 'usuarioID';
    _estado := coalesce(cast(req ->> 'estado' as bool), true);
    _deleted := coalesce(cast(req ->> 'deleted' as bool) , false);
    if _id is null then
        insert into marcas (estado, deleted, usuario_id, nombre,slug)
        values (_estado, _deleted, _usuario_id, _nombre,_slug);
        _id:=lastval();
        result:=json_build_object('ID',_id,'status','INSERT');
    else
        update marcas
        set nombre=_nombre,
            estado=_estado,
            deleted=_deleted,
            usuario_id=_usuario_id,
            slug=_slug
        where id = _id;
        result:=json_build_object('ID',_id,'status','UPDATE');
    end if;
    return coalesce(result, '{}'::json);
end;
$$;
 0   DROP FUNCTION public.post_add_marcas(req json);
       public          postgres    false            �            1255    16915    post_add_modelos(json)    FUNCTION     �  CREATE FUNCTION public.post_add_modelos(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
    _id         int;
    _nombre     varchar;
    _slug     varchar;
    _usuario_id int;
    _marca_id int;
    _estado     bool;
    _deleted    bool;
    result      json;
begin
    _id := req ->> 'id';
    _marca_id := req ->> 'marcaID';
    _nombre := req ->> 'nombre';
    _slug := req ->> 'slug';
    _usuario_id := req ->> 'usuarioID';
    _estado := coalesce(cast(req ->> 'estado' as bool), true);
    _deleted := coalesce(cast(req ->> 'deleted' as bool) , false);
    if _id is null then
        insert into modelos (estado, deleted, usuario_id, nombre,slug,marca_id)
        values (_estado, _deleted, _usuario_id, _nombre,_slug,_marca_id);
        _id:=lastval();
        result:=json_build_object('ID',_id,'status','INSERT');
    else
        update modelos
        set nombre=_nombre,
            estado=_estado,
            deleted=_deleted,
            marca_id=_marca_id,
            usuario_id=_usuario_id,
            slug=_slug
        where id = _id;
        result:=json_build_object('ID',_id,'status','UPDATE');
    end if;
    return coalesce(result, '{}'::json);
end;
$$;
 1   DROP FUNCTION public.post_add_modelos(req json);
       public          postgres    false            �            1255    16918    post_add_persona(json)    FUNCTION       CREATE FUNCTION public.post_add_persona(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
    _id               int;
    _nombre           varchar;
    _slug             varchar;
    _usuario_id       int;
    _estado           bool;
    _deleted          bool;
    _paterno          varchar;
    _materno          varchar;
    _full_name        varchar;
    _dni              varchar;
    _direccion        varchar;
    _celular          varchar;
    _sexo             varchar;
    _fecha_nacimiento int;
    result            json;
begin
    _id := req ->> 'id';
    _nombre := req ->> 'nombre';
    _usuario_id := req ->> 'usuarioID';
    _estado := coalesce(cast(req ->> 'estado' as bool), true);
    _deleted := coalesce(cast(req ->> 'deleted' as bool), false);
    _paterno := req ->> 'paterno';
    _materno := req ->> 'materno';
    _full_name := req ->> 'fullname';
    _dni := req ->> 'dni';
    _direccion := req ->> 'direccion';
    _celular := req ->> 'celular';
    _sexo := req ->> 'sexo';
    _fecha_nacimiento := cast(req ->> 'fechaNacimiento' as int);
    if _id is null then
        insert into persona (estado, deleted, usuario_id, nombre, celular,
                             direccion, dni, fecha_nacimiento, full_name, materno, paterno)
        values (_estado, _deleted, _usuario_id, _nombre, _celular,_direccion,_dni,
                _fecha_nacimiento,_full_name,_materno,_paterno);
        _id := lastval();
        result := json_build_object('ID', _id, 'status', 'INSERT');
    else
        update persona
        set nombre=_nombre,
            estado=_estado,
            deleted=_deleted,
            usuario_id=_usuario_id,
            celular=_celular,
            direccion=_direccion,
            dni=_dni,
            fecha_nacimiento=_fecha_nacimiento,
            full_name=_full_name,
            materno=_materno,
            paterno=_paterno
        where id = _id;
        result := json_build_object('ID', _id, 'status', 'UPDATE');
    end if;
    return coalesce(result, '{}'::json);
end;
$$;
 1   DROP FUNCTION public.post_add_persona(req json);
       public          postgres    false                        1255    16917    post_add_tipo_vehiculos(json)    FUNCTION     X  CREATE FUNCTION public.post_add_tipo_vehiculos(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
    _id         int;
    _nombre     varchar;
    _slug     varchar;
    _usuario_id int;
    _estado     bool;
    _deleted    bool;
    result      json;
begin
    _id := req ->> 'id';
    _nombre := req ->> 'nombre';
    _slug := req ->> 'slug';
    _usuario_id := req ->> 'usuarioID';
    _estado := coalesce(cast(req ->> 'estado' as bool), true);
    _deleted := coalesce(cast(req ->> 'deleted' as bool) , false);
    if _id is null then
        insert into tipo_vehiculo (estado, deleted, usuario_id, nombre,slug)
        values (_estado, _deleted, _usuario_id, _nombre,_slug);
        _id:=lastval();
        result:=json_build_object('ID',_id,'status','INSERT');
    else
        update tipo_vehiculo
        set nombre=_nombre,
            estado=_estado,
            deleted=_deleted,
            usuario_id=_usuario_id,
            slug=_slug
        where id = _id;
        result:=json_build_object('ID',_id,'status','UPDATE');
    end if;
    return coalesce(result, '{}'::json);
end;
$$;
 8   DROP FUNCTION public.post_add_tipo_vehiculos(req json);
       public          postgres    false                       1255    16922    post_add_vehiculo(json)    FUNCTION     7  CREATE FUNCTION public.post_add_vehiculo(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
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
 2   DROP FUNCTION public.post_add_vehiculo(req json);
       public          postgres    false                       1255    16921    login_usuario(json)    FUNCTION     �  CREATE FUNCTION seguridad.login_usuario(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
    _id    int;
     _username           varchar;
    result json;
begin
    _username=req->>'username';
    result := (select json_agg(t.*)
               from (select u.id, u.estado, u.deleted, u.usuario_id "usuarioID",u.username,u.password,
                            u.persona_id "personaID",p.full_name as "fullname"
                     from seguridad.usuario u left join public.persona p on u.id = p.usuario_id
                     where u.deleted = false and u.username=_username) as t);
    return coalesce(result, '[]'::json);
end ;
$$;
 1   DROP FUNCTION seguridad.login_usuario(req json);
    	   seguridad          postgres    false    8                       1255    16920    post_add_usuario(json)    FUNCTION     �  CREATE FUNCTION seguridad.post_add_usuario(req json) RETURNS json
    LANGUAGE plpgsql
    AS $$
declare
    _id               int;
    _nombre           varchar;
    _usuario_id       int;
    _estado           bool;
    _deleted           bool;
    _filiales_ids int[];
    _roles_ids int[];
    _password varchar;
    _username varchar;
    _persona_id int;
    result            json;
begin
    _id := req ->> 'id';
    _nombre := req ->> 'nombre';
    _usuario_id := req ->> 'usuarioID';
    _estado := coalesce(cast(req ->> 'estado' as bool), true);
    _deleted := coalesce(cast(req ->> 'deleted' as bool), false);
    _filiales_ids :=cast(req ->> 'filialesIDs' as int[]) ;
    _roles_ids :=cast(req ->> 'rolesIDs' as int[]) ;
    _password := req ->> 'password';
    _username := req ->> 'username';
    _persona_id := req ->> 'personaID';

    if _id is null then
        insert into seguridad.usuario (estado, deleted, usuario_id, filiales_ids,password,roles_ids,persona_id,username)
        values (_estado, _deleted, _usuario_id, _filiales_ids,_password,_roles_ids,_persona_id,_username) ;
        _id := lastval();
        result := json_build_object('ID', _id, 'status', 'INSERT');
    else
        update seguridad.usuario
        set
            estado=_estado,
            deleted=_deleted,
            usuario_id=_usuario_id,
            username=_username,
            persona_id=_persona_id,
            roles_ids=_roles_ids,
            password=_password,
            filiales_ids=_filiales_ids
        where id = _id;
        result := json_build_object('ID', _id, 'status', 'UPDATE');
    end if;
    return coalesce(result, '{}'::json);
end;
$$;
 4   DROP FUNCTION seguridad.post_add_usuario(req json);
    	   seguridad          postgres    false    8            �            1259    16843    combustible    TABLE     X  CREATE TABLE public.combustible (
    estado boolean DEFAULT true NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    nombre character varying NOT NULL
);
    DROP TABLE public.combustible;
       public         heap    postgres    false            �            1259    16841    combustible_id_seq    SEQUENCE     �   CREATE SEQUENCE public.combustible_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.combustible_id_seq;
       public          postgres    false    232            �           0    0    combustible_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.combustible_id_seq OWNED BY public.combustible.id;
          public          postgres    false    231            �            1259    16613 
   documentos    TABLE     �  CREATE TABLE public.documentos (
    estado boolean DEFAULT true NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    nombre character varying NOT NULL,
    path character varying NOT NULL,
    vehiculo_id integer
);
    DROP TABLE public.documentos;
       public         heap    postgres    false            �            1259    16611    documentos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.documentos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.documentos_id_seq;
       public          postgres    false    204            �           0    0    documentos_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.documentos_id_seq OWNED BY public.documentos.id;
          public          postgres    false    203            �            1259    16828    grupo    TABLE     R  CREATE TABLE public.grupo (
    estado boolean DEFAULT true NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    nombre character varying NOT NULL
);
    DROP TABLE public.grupo;
       public         heap    postgres    false            �            1259    16826    grupo_id_seq    SEQUENCE     �   CREATE SEQUENCE public.grupo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.grupo_id_seq;
       public          postgres    false    230            �           0    0    grupo_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.grupo_id_seq OWNED BY public.grupo.id;
          public          postgres    false    229            �            1259    16653    marcas    TABLE     x  CREATE TABLE public.marcas (
    estado boolean DEFAULT true NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    nombre character varying NOT NULL,
    slug character varying NOT NULL
);
    DROP TABLE public.marcas;
       public         heap    postgres    false            �            1259    16651    marcas_id_seq    SEQUENCE     �   CREATE SEQUENCE public.marcas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.marcas_id_seq;
       public          postgres    false    208            �           0    0    marcas_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.marcas_id_seq OWNED BY public.marcas.id;
          public          postgres    false    207            �            1259    16636    modelos    TABLE     �  CREATE TABLE public.modelos (
    estado boolean DEFAULT true NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    nombre character varying NOT NULL,
    slug character varying NOT NULL,
    marca_id integer
);
    DROP TABLE public.modelos;
       public         heap    postgres    false            �            1259    16634    modelos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.modelos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.modelos_id_seq;
       public          postgres    false    206            �           0    0    modelos_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.modelos_id_seq OWNED BY public.modelos.id;
          public          postgres    false    205            �            1259    16777    organizacion    TABLE     ,  CREATE TABLE public.organizacion (
    estado boolean DEFAULT true NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    ruc character varying NOT NULL,
    nombre character varying NOT NULL,
    razon_social character varying NOT NULL,
    direccion character varying,
    email character varying,
    celular character varying,
    logo character varying NOT NULL
);
     DROP TABLE public.organizacion;
       public         heap    postgres    false            �            1259    16775    organizacion_id_seq    SEQUENCE     �   CREATE SEQUENCE public.organizacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.organizacion_id_seq;
       public          postgres    false    224            �           0    0    organizacion_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.organizacion_id_seq OWNED BY public.organizacion.id;
          public          postgres    false    223            �            1259    16811    persona    TABLE     l  CREATE TABLE public.persona (
    estado boolean DEFAULT true NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    nombre character varying NOT NULL,
    paterno character varying NOT NULL,
    materno character varying NOT NULL,
    full_name character varying NOT NULL,
    dni character varying NOT NULL,
    direccion character varying,
    celular character varying,
    fecha_nacimiento integer,
    sexo character varying
);
    DROP TABLE public.persona;
       public         heap    postgres    false            �            1259    16809    persona_id_seq    SEQUENCE     �   CREATE SEQUENCE public.persona_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.persona_id_seq;
       public          postgres    false    228            �           0    0    persona_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.persona_id_seq OWNED BY public.persona.id;
          public          postgres    false    227            �            1259    16762    sucursal    TABLE     !  CREATE TABLE public.sucursal (
    estado boolean DEFAULT true NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    nombre character varying NOT NULL,
    razon_social character varying NOT NULL,
    direccion character varying,
    email character varying,
    celular character varying,
    logo character varying NOT NULL,
    organizacion_id integer
);
    DROP TABLE public.sucursal;
       public         heap    postgres    false            �            1259    16760    sucursal_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sucursal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.sucursal_id_seq;
       public          postgres    false    222            �           0    0    sucursal_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.sucursal_id_seq OWNED BY public.sucursal.id;
          public          postgres    false    221            �            1259    16670    tipo_vehiculo    TABLE       CREATE TABLE public.tipo_vehiculo (
    estado boolean DEFAULT true NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    nombre character varying NOT NULL,
    slug character varying NOT NULL
);
 !   DROP TABLE public.tipo_vehiculo;
       public         heap    postgres    false            �            1259    16668    tipo_vehiculo_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tipo_vehiculo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.tipo_vehiculo_id_seq;
       public          postgres    false    210            �           0    0    tipo_vehiculo_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.tipo_vehiculo_id_seq OWNED BY public.tipo_vehiculo.id;
          public          postgres    false    209            �            1259    16689    vehiculo    TABLE     F  CREATE TABLE public.vehiculo (
    id integer NOT NULL,
    nombre character varying NOT NULL,
    placa character varying NOT NULL,
    "año" integer NOT NULL,
    estado character varying,
    estado_descripcion character varying,
    provincia_registro character varying NOT NULL,
    fotografia character varying,
    propiedad character varying NOT NULL,
    tarjeta_circulacion character varying NOT NULL,
    fech_venc_tarjeta_circulacion integer NOT NULL,
    tarjeta_propiedad character varying NOT NULL,
    fech_venc_tarjeta_propiedad integer NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    color character varying NOT NULL,
    motor character varying NOT NULL,
    cilindros integer NOT NULL,
    cilindrada character varying NOT NULL,
    combustible_id integer NOT NULL,
    grupo_id integer NOT NULL,
    tipo_vehiculo_id integer,
    marca_id integer,
    modelo_id integer,
    vin_sin character varying
);
    DROP TABLE public.vehiculo;
       public         heap    postgres    false            �            1259    16687    vehiculo_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vehiculo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.vehiculo_id_seq;
       public          postgres    false    212            �           0    0    vehiculo_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.vehiculo_id_seq OWNED BY public.vehiculo.id;
          public          postgres    false    211            �            1259    16732    menu    TABLE     �  CREATE TABLE seguridad.menu (
    estado boolean DEFAULT true NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    nombre character varying NOT NULL,
    url character varying NOT NULL,
    icono character varying NOT NULL
);
    DROP TABLE seguridad.menu;
    	   seguridad         heap    postgres    false    8            �            1259    16730    menu_id_seq    SEQUENCE     �   CREATE SEQUENCE seguridad.menu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE seguridad.menu_id_seq;
    	   seguridad          postgres    false    8    218            �           0    0    menu_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE seguridad.menu_id_seq OWNED BY seguridad.menu.id;
       	   seguridad          postgres    false    217            �            1259    16705    rol    TABLE     o  CREATE TABLE seguridad.rol (
    estado boolean DEFAULT true NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    nombre character varying NOT NULL,
    filiales_ids integer[]
);
    DROP TABLE seguridad.rol;
    	   seguridad         heap    postgres    false    8            �            1259    16703 
   rol_id_seq    SEQUENCE     �   CREATE SEQUENCE seguridad.rol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE seguridad.rol_id_seq;
    	   seguridad          postgres    false    214    8            �           0    0 
   rol_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE seguridad.rol_id_seq OWNED BY seguridad.rol.id;
       	   seguridad          postgres    false    213            �            1259    16720    rol_submenu    TABLE     `  CREATE TABLE seguridad.rol_submenu (
    estado boolean DEFAULT true NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    rol_id integer,
    submenu_id integer
);
 "   DROP TABLE seguridad.rol_submenu;
    	   seguridad         heap    postgres    false    8            �            1259    16718    rol_submenu_id_seq    SEQUENCE     �   CREATE SEQUENCE seguridad.rol_submenu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE seguridad.rol_submenu_id_seq;
    	   seguridad          postgres    false    8    216            �           0    0    rol_submenu_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE seguridad.rol_submenu_id_seq OWNED BY seguridad.rol_submenu.id;
       	   seguridad          postgres    false    215            �            1259    16747    submenu    TABLE     �  CREATE TABLE seguridad.submenu (
    estado boolean DEFAULT true NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    nombre character varying NOT NULL,
    url character varying NOT NULL,
    icono character varying NOT NULL,
    menu_id integer
);
    DROP TABLE seguridad.submenu;
    	   seguridad         heap    postgres    false    8            �            1259    16745    submenu_id_seq    SEQUENCE     �   CREATE SEQUENCE seguridad.submenu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE seguridad.submenu_id_seq;
    	   seguridad          postgres    false    8    220            �           0    0    submenu_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE seguridad.submenu_id_seq OWNED BY seguridad.submenu.id;
       	   seguridad          postgres    false    219            �            1259    16792    usuario    TABLE     �  CREATE TABLE seguridad.usuario (
    estado boolean DEFAULT true NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    usuario_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL,
    filiales_ids integer[],
    roles_ids integer[],
    persona_id integer
);
    DROP TABLE seguridad.usuario;
    	   seguridad         heap    postgres    false    8            �            1259    16790    usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE seguridad.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE seguridad.usuario_id_seq;
    	   seguridad          postgres    false    226    8            �           0    0    usuario_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE seguridad.usuario_id_seq OWNED BY seguridad.usuario.id;
       	   seguridad          postgres    false    225            �           2604    16850    combustible id    DEFAULT     p   ALTER TABLE ONLY public.combustible ALTER COLUMN id SET DEFAULT nextval('public.combustible_id_seq'::regclass);
 =   ALTER TABLE public.combustible ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    231    232    232            �           2604    16620    documentos id    DEFAULT     n   ALTER TABLE ONLY public.documentos ALTER COLUMN id SET DEFAULT nextval('public.documentos_id_seq'::regclass);
 <   ALTER TABLE public.documentos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    204    204            �           2604    16835    grupo id    DEFAULT     d   ALTER TABLE ONLY public.grupo ALTER COLUMN id SET DEFAULT nextval('public.grupo_id_seq'::regclass);
 7   ALTER TABLE public.grupo ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229    230            �           2604    16660 	   marcas id    DEFAULT     f   ALTER TABLE ONLY public.marcas ALTER COLUMN id SET DEFAULT nextval('public.marcas_id_seq'::regclass);
 8   ALTER TABLE public.marcas ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    208    207    208            �           2604    16643 
   modelos id    DEFAULT     h   ALTER TABLE ONLY public.modelos ALTER COLUMN id SET DEFAULT nextval('public.modelos_id_seq'::regclass);
 9   ALTER TABLE public.modelos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    205    206            �           2604    16784    organizacion id    DEFAULT     r   ALTER TABLE ONLY public.organizacion ALTER COLUMN id SET DEFAULT nextval('public.organizacion_id_seq'::regclass);
 >   ALTER TABLE public.organizacion ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223    224            �           2604    16818 
   persona id    DEFAULT     h   ALTER TABLE ONLY public.persona ALTER COLUMN id SET DEFAULT nextval('public.persona_id_seq'::regclass);
 9   ALTER TABLE public.persona ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227    228            �           2604    16769    sucursal id    DEFAULT     j   ALTER TABLE ONLY public.sucursal ALTER COLUMN id SET DEFAULT nextval('public.sucursal_id_seq'::regclass);
 :   ALTER TABLE public.sucursal ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221    222            �           2604    16677    tipo_vehiculo id    DEFAULT     t   ALTER TABLE ONLY public.tipo_vehiculo ALTER COLUMN id SET DEFAULT nextval('public.tipo_vehiculo_id_seq'::regclass);
 ?   ALTER TABLE public.tipo_vehiculo ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    210    210            �           2604    16692    vehiculo id    DEFAULT     j   ALTER TABLE ONLY public.vehiculo ALTER COLUMN id SET DEFAULT nextval('public.vehiculo_id_seq'::regclass);
 :   ALTER TABLE public.vehiculo ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    211    212            �           2604    16739    menu id    DEFAULT     h   ALTER TABLE ONLY seguridad.menu ALTER COLUMN id SET DEFAULT nextval('seguridad.menu_id_seq'::regclass);
 9   ALTER TABLE seguridad.menu ALTER COLUMN id DROP DEFAULT;
    	   seguridad          postgres    false    218    217    218            �           2604    16712    rol id    DEFAULT     f   ALTER TABLE ONLY seguridad.rol ALTER COLUMN id SET DEFAULT nextval('seguridad.rol_id_seq'::regclass);
 8   ALTER TABLE seguridad.rol ALTER COLUMN id DROP DEFAULT;
    	   seguridad          postgres    false    213    214    214            �           2604    16727    rol_submenu id    DEFAULT     v   ALTER TABLE ONLY seguridad.rol_submenu ALTER COLUMN id SET DEFAULT nextval('seguridad.rol_submenu_id_seq'::regclass);
 @   ALTER TABLE seguridad.rol_submenu ALTER COLUMN id DROP DEFAULT;
    	   seguridad          postgres    false    215    216    216            �           2604    16754 
   submenu id    DEFAULT     n   ALTER TABLE ONLY seguridad.submenu ALTER COLUMN id SET DEFAULT nextval('seguridad.submenu_id_seq'::regclass);
 <   ALTER TABLE seguridad.submenu ALTER COLUMN id DROP DEFAULT;
    	   seguridad          postgres    false    219    220    220            �           2604    16799 
   usuario id    DEFAULT     n   ALTER TABLE ONLY seguridad.usuario ALTER COLUMN id SET DEFAULT nextval('seguridad.usuario_id_seq'::regclass);
 <   ALTER TABLE seguridad.usuario ALTER COLUMN id DROP DEFAULT;
    	   seguridad          postgres    false    226    225    226            �          0    16843    combustible 
   TABLE DATA           f   COPY public.combustible (estado, deleted, usuario_id, created_at, updated_at, id, nombre) FROM stdin;
    public          postgres    false    232   .      �          0    16613 
   documentos 
   TABLE DATA           x   COPY public.documentos (estado, deleted, usuario_id, created_at, updated_at, id, nombre, path, vehiculo_id) FROM stdin;
    public          postgres    false    204   �      �          0    16828    grupo 
   TABLE DATA           `   COPY public.grupo (estado, deleted, usuario_id, created_at, updated_at, id, nombre) FROM stdin;
    public          postgres    false    230   �      �          0    16653    marcas 
   TABLE DATA           g   COPY public.marcas (estado, deleted, usuario_id, created_at, updated_at, id, nombre, slug) FROM stdin;
    public          postgres    false    208         �          0    16636    modelos 
   TABLE DATA           r   COPY public.modelos (estado, deleted, usuario_id, created_at, updated_at, id, nombre, slug, marca_id) FROM stdin;
    public          postgres    false    206   �      �          0    16777    organizacion 
   TABLE DATA           �   COPY public.organizacion (estado, deleted, usuario_id, created_at, updated_at, id, ruc, nombre, razon_social, direccion, email, celular, logo) FROM stdin;
    public          postgres    false    224   �      �          0    16811    persona 
   TABLE DATA           �   COPY public.persona (estado, deleted, usuario_id, created_at, updated_at, id, nombre, paterno, materno, full_name, dni, direccion, celular, fecha_nacimiento, sexo) FROM stdin;
    public          postgres    false    228   
      �          0    16762    sucursal 
   TABLE DATA           �   COPY public.sucursal (estado, deleted, usuario_id, created_at, updated_at, id, nombre, razon_social, direccion, email, celular, logo, organizacion_id) FROM stdin;
    public          postgres    false    222   z      �          0    16670    tipo_vehiculo 
   TABLE DATA           n   COPY public.tipo_vehiculo (estado, deleted, usuario_id, created_at, updated_at, id, nombre, slug) FROM stdin;
    public          postgres    false    210   �      �          0    16689    vehiculo 
   TABLE DATA           �  COPY public.vehiculo (id, nombre, placa, "año", estado, estado_descripcion, provincia_registro, fotografia, propiedad, tarjeta_circulacion, fech_venc_tarjeta_circulacion, tarjeta_propiedad, fech_venc_tarjeta_propiedad, deleted, usuario_id, created_at, updated_at, color, motor, cilindros, cilindrada, combustible_id, grupo_id, tipo_vehiculo_id, marca_id, modelo_id, vin_sin) FROM stdin;
    public          postgres    false    212   �      �          0    16732    menu 
   TABLE DATA           n   COPY seguridad.menu (estado, deleted, usuario_id, created_at, updated_at, id, nombre, url, icono) FROM stdin;
 	   seguridad          postgres    false    218   �      �          0    16705    rol 
   TABLE DATA           o   COPY seguridad.rol (estado, deleted, usuario_id, created_at, updated_at, id, nombre, filiales_ids) FROM stdin;
 	   seguridad          postgres    false    214   �      �          0    16720    rol_submenu 
   TABLE DATA           u   COPY seguridad.rol_submenu (estado, deleted, usuario_id, created_at, updated_at, id, rol_id, submenu_id) FROM stdin;
 	   seguridad          postgres    false    216   �      �          0    16747    submenu 
   TABLE DATA           z   COPY seguridad.submenu (estado, deleted, usuario_id, created_at, updated_at, id, nombre, url, icono, menu_id) FROM stdin;
 	   seguridad          postgres    false    220   �      �          0    16792    usuario 
   TABLE DATA           �   COPY seguridad.usuario (estado, deleted, usuario_id, created_at, updated_at, id, username, password, filiales_ids, roles_ids, persona_id) FROM stdin;
 	   seguridad          postgres    false    226   	      �           0    0    combustible_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.combustible_id_seq', 2, true);
          public          postgres    false    231            �           0    0    documentos_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.documentos_id_seq', 1, false);
          public          postgres    false    203            �           0    0    grupo_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.grupo_id_seq', 2, true);
          public          postgres    false    229            �           0    0    marcas_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.marcas_id_seq', 2, true);
          public          postgres    false    207            �           0    0    modelos_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.modelos_id_seq', 2, true);
          public          postgres    false    205            �           0    0    organizacion_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.organizacion_id_seq', 1, false);
          public          postgres    false    223            �           0    0    persona_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.persona_id_seq', 1, true);
          public          postgres    false    227            �           0    0    sucursal_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.sucursal_id_seq', 1, false);
          public          postgres    false    221            �           0    0    tipo_vehiculo_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.tipo_vehiculo_id_seq', 2, true);
          public          postgres    false    209            �           0    0    vehiculo_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.vehiculo_id_seq', 1, true);
          public          postgres    false    211            �           0    0    menu_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('seguridad.menu_id_seq', 1, false);
       	   seguridad          postgres    false    217            �           0    0 
   rol_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('seguridad.rol_id_seq', 1, false);
       	   seguridad          postgres    false    213            �           0    0    rol_submenu_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('seguridad.rol_submenu_id_seq', 1, false);
       	   seguridad          postgres    false    215            �           0    0    submenu_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('seguridad.submenu_id_seq', 1, false);
       	   seguridad          postgres    false    219            �           0    0    usuario_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('seguridad.usuario_id_seq', 1, true);
       	   seguridad          postgres    false    225            �           2606    16665 %   marcas PK_0dabf9ed9a15bfb634cb675f7d4 
   CONSTRAINT     e   ALTER TABLE ONLY public.marcas
    ADD CONSTRAINT "PK_0dabf9ed9a15bfb634cb675f7d4" PRIMARY KEY (id);
 Q   ALTER TABLE ONLY public.marcas DROP CONSTRAINT "PK_0dabf9ed9a15bfb634cb675f7d4";
       public            postgres    false    208                       2606    16823 &   persona PK_13aefc75f60510f2be4cd243d71 
   CONSTRAINT     f   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT "PK_13aefc75f60510f2be4cd243d71" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.persona DROP CONSTRAINT "PK_13aefc75f60510f2be4cd243d71";
       public            postgres    false    228            �           2606    16627 )   documentos PK_30b7ee230a352e7582842d1dc02 
   CONSTRAINT     i   ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT "PK_30b7ee230a352e7582842d1dc02" PRIMARY KEY (id);
 U   ALTER TABLE ONLY public.documentos DROP CONSTRAINT "PK_30b7ee230a352e7582842d1dc02";
       public            postgres    false    204                       2606    16855 *   combustible PK_5c84c0c106858954f5ba8aaba53 
   CONSTRAINT     j   ALTER TABLE ONLY public.combustible
    ADD CONSTRAINT "PK_5c84c0c106858954f5ba8aaba53" PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.combustible DROP CONSTRAINT "PK_5c84c0c106858954f5ba8aaba53";
       public            postgres    false    232            �           2606    16700 '   vehiculo PK_79ad0f38366031fd4f2c1efdc62 
   CONSTRAINT     g   ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT "PK_79ad0f38366031fd4f2c1efdc62" PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.vehiculo DROP CONSTRAINT "PK_79ad0f38366031fd4f2c1efdc62";
       public            postgres    false    212            
           2606    16789 +   organizacion PK_a02a7a5d4ac603d02ffc5db8fb8 
   CONSTRAINT     k   ALTER TABLE ONLY public.organizacion
    ADD CONSTRAINT "PK_a02a7a5d4ac603d02ffc5db8fb8" PRIMARY KEY (id);
 W   ALTER TABLE ONLY public.organizacion DROP CONSTRAINT "PK_a02a7a5d4ac603d02ffc5db8fb8";
       public            postgres    false    224                       2606    16774 '   sucursal PK_a3817e81fd6972dd2172d9c4e60 
   CONSTRAINT     g   ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT "PK_a3817e81fd6972dd2172d9c4e60" PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.sucursal DROP CONSTRAINT "PK_a3817e81fd6972dd2172d9c4e60";
       public            postgres    false    222            �           2606    16682 ,   tipo_vehiculo PK_c612b4b7ab508c6d971df180c30 
   CONSTRAINT     l   ALTER TABLE ONLY public.tipo_vehiculo
    ADD CONSTRAINT "PK_c612b4b7ab508c6d971df180c30" PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.tipo_vehiculo DROP CONSTRAINT "PK_c612b4b7ab508c6d971df180c30";
       public            postgres    false    210                       2606    16840 $   grupo PK_dc8777104b615fea76db518334f 
   CONSTRAINT     d   ALTER TABLE ONLY public.grupo
    ADD CONSTRAINT "PK_dc8777104b615fea76db518334f" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.grupo DROP CONSTRAINT "PK_dc8777104b615fea76db518334f";
       public            postgres    false    230            �           2606    16650 &   modelos PK_e9df275f890167381d41c793603 
   CONSTRAINT     f   ALTER TABLE ONLY public.modelos
    ADD CONSTRAINT "PK_e9df275f890167381d41c793603" PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.modelos DROP CONSTRAINT "PK_e9df275f890167381d41c793603";
       public            postgres    false    206                       2606    16825 &   persona UQ_9be1c357217009199edce98d4db 
   CONSTRAINT     b   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT "UQ_9be1c357217009199edce98d4db" UNIQUE (dni);
 R   ALTER TABLE ONLY public.persona DROP CONSTRAINT "UQ_9be1c357217009199edce98d4db";
       public            postgres    false    228                       2606    16729 *   rol_submenu PK_26109647d06e3ada5cb2e790f64 
   CONSTRAINT     m   ALTER TABLE ONLY seguridad.rol_submenu
    ADD CONSTRAINT "PK_26109647d06e3ada5cb2e790f64" PRIMARY KEY (id);
 Y   ALTER TABLE ONLY seguridad.rol_submenu DROP CONSTRAINT "PK_26109647d06e3ada5cb2e790f64";
    	   seguridad            postgres    false    216                       2606    16744 #   menu PK_35b2a8f47d153ff7a41860cceeb 
   CONSTRAINT     f   ALTER TABLE ONLY seguridad.menu
    ADD CONSTRAINT "PK_35b2a8f47d153ff7a41860cceeb" PRIMARY KEY (id);
 R   ALTER TABLE ONLY seguridad.menu DROP CONSTRAINT "PK_35b2a8f47d153ff7a41860cceeb";
    	   seguridad            postgres    false    218                       2606    16759 &   submenu PK_47cc7a60c15cfb401f49b0897e7 
   CONSTRAINT     i   ALTER TABLE ONLY seguridad.submenu
    ADD CONSTRAINT "PK_47cc7a60c15cfb401f49b0897e7" PRIMARY KEY (id);
 U   ALTER TABLE ONLY seguridad.submenu DROP CONSTRAINT "PK_47cc7a60c15cfb401f49b0897e7";
    	   seguridad            postgres    false    220                       2606    16804 &   usuario PK_a56c58e5cabaa04fb2c98d2d7e2 
   CONSTRAINT     i   ALTER TABLE ONLY seguridad.usuario
    ADD CONSTRAINT "PK_a56c58e5cabaa04fb2c98d2d7e2" PRIMARY KEY (id);
 U   ALTER TABLE ONLY seguridad.usuario DROP CONSTRAINT "PK_a56c58e5cabaa04fb2c98d2d7e2";
    	   seguridad            postgres    false    226                        2606    16717 "   rol PK_c93a22388638fac311781c7f2dd 
   CONSTRAINT     e   ALTER TABLE ONLY seguridad.rol
    ADD CONSTRAINT "PK_c93a22388638fac311781c7f2dd" PRIMARY KEY (id);
 Q   ALTER TABLE ONLY seguridad.rol DROP CONSTRAINT "PK_c93a22388638fac311781c7f2dd";
    	   seguridad            postgres    false    214                       2606    16808 &   usuario REL_c9d223fa9cc0ea30abcd9d5ca7 
   CONSTRAINT     l   ALTER TABLE ONLY seguridad.usuario
    ADD CONSTRAINT "REL_c9d223fa9cc0ea30abcd9d5ca7" UNIQUE (persona_id);
 U   ALTER TABLE ONLY seguridad.usuario DROP CONSTRAINT "REL_c9d223fa9cc0ea30abcd9d5ca7";
    	   seguridad            postgres    false    226                       2606    16806 &   usuario UQ_6ccff37176a6978449a99c82e10 
   CONSTRAINT     j   ALTER TABLE ONLY seguridad.usuario
    ADD CONSTRAINT "UQ_6ccff37176a6978449a99c82e10" UNIQUE (username);
 U   ALTER TABLE ONLY seguridad.usuario DROP CONSTRAINT "UQ_6ccff37176a6978449a99c82e10";
    	   seguridad            postgres    false    226                       2606    16856 )   documentos FK_314e1a81b76457cdf77fbc6253d    FK CONSTRAINT     �   ALTER TABLE ONLY public.documentos
    ADD CONSTRAINT "FK_314e1a81b76457cdf77fbc6253d" FOREIGN KEY (vehiculo_id) REFERENCES public.vehiculo(id);
 U   ALTER TABLE ONLY public.documentos DROP CONSTRAINT "FK_314e1a81b76457cdf77fbc6253d";
       public          postgres    false    212    3070    204            !           2606    16896 '   sucursal FK_80c245b41789d7946c1ac72559c    FK CONSTRAINT     �   ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT "FK_80c245b41789d7946c1ac72559c" FOREIGN KEY (organizacion_id) REFERENCES public.organizacion(id);
 S   ALTER TABLE ONLY public.sucursal DROP CONSTRAINT "FK_80c245b41789d7946c1ac72559c";
       public          postgres    false    222    3082    224                       2606    16866 '   vehiculo FK_a3bea703f931d02b1f34977f6e5    FK CONSTRAINT     �   ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT "FK_a3bea703f931d02b1f34977f6e5" FOREIGN KEY (tipo_vehiculo_id) REFERENCES public.tipo_vehiculo(id);
 S   ALTER TABLE ONLY public.vehiculo DROP CONSTRAINT "FK_a3bea703f931d02b1f34977f6e5";
       public          postgres    false    210    3068    212                       2606    16861 &   modelos FK_c0e31b1cdff2abf1f9dc0a5937e    FK CONSTRAINT     �   ALTER TABLE ONLY public.modelos
    ADD CONSTRAINT "FK_c0e31b1cdff2abf1f9dc0a5937e" FOREIGN KEY (marca_id) REFERENCES public.marcas(id);
 R   ALTER TABLE ONLY public.modelos DROP CONSTRAINT "FK_c0e31b1cdff2abf1f9dc0a5937e";
       public          postgres    false    208    3066    206                       2606    16871 '   vehiculo FK_e0a30817bd97881cc085b0c22bb    FK CONSTRAINT     �   ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT "FK_e0a30817bd97881cc085b0c22bb" FOREIGN KEY (marca_id) REFERENCES public.marcas(id);
 S   ALTER TABLE ONLY public.vehiculo DROP CONSTRAINT "FK_e0a30817bd97881cc085b0c22bb";
       public          postgres    false    208    212    3066                       2606    16876 '   vehiculo FK_f1e452c910433f60ebd2f6ebd3c    FK CONSTRAINT     �   ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT "FK_f1e452c910433f60ebd2f6ebd3c" FOREIGN KEY (modelo_id) REFERENCES public.marcas(id);
 S   ALTER TABLE ONLY public.vehiculo DROP CONSTRAINT "FK_f1e452c910433f60ebd2f6ebd3c";
       public          postgres    false    3066    208    212                       2606    16881 *   rol_submenu FK_a33f555e7a99f29beb5b46dd04c    FK CONSTRAINT     �   ALTER TABLE ONLY seguridad.rol_submenu
    ADD CONSTRAINT "FK_a33f555e7a99f29beb5b46dd04c" FOREIGN KEY (rol_id) REFERENCES seguridad.rol(id);
 Y   ALTER TABLE ONLY seguridad.rol_submenu DROP CONSTRAINT "FK_a33f555e7a99f29beb5b46dd04c";
    	   seguridad          postgres    false    214    3072    216                       2606    16886 *   rol_submenu FK_a6d5db4facf77d4f1bdffb2cc1c    FK CONSTRAINT     �   ALTER TABLE ONLY seguridad.rol_submenu
    ADD CONSTRAINT "FK_a6d5db4facf77d4f1bdffb2cc1c" FOREIGN KEY (submenu_id) REFERENCES seguridad.submenu(id);
 Y   ALTER TABLE ONLY seguridad.rol_submenu DROP CONSTRAINT "FK_a6d5db4facf77d4f1bdffb2cc1c";
    	   seguridad          postgres    false    220    3078    216                        2606    16891 &   submenu FK_b5decd298bee5aac8199f3f1648    FK CONSTRAINT     �   ALTER TABLE ONLY seguridad.submenu
    ADD CONSTRAINT "FK_b5decd298bee5aac8199f3f1648" FOREIGN KEY (menu_id) REFERENCES seguridad.menu(id);
 U   ALTER TABLE ONLY seguridad.submenu DROP CONSTRAINT "FK_b5decd298bee5aac8199f3f1648";
    	   seguridad          postgres    false    218    3076    220            "           2606    16901 &   usuario FK_c9d223fa9cc0ea30abcd9d5ca7e    FK CONSTRAINT     �   ALTER TABLE ONLY seguridad.usuario
    ADD CONSTRAINT "FK_c9d223fa9cc0ea30abcd9d5ca7e" FOREIGN KEY (persona_id) REFERENCES public.persona(id);
 U   ALTER TABLE ONLY seguridad.usuario DROP CONSTRAINT "FK_c9d223fa9cc0ea30abcd9d5ca7e";
    	   seguridad          postgres    false    226    3090    228            �   W   x�+�L���4202�50�50U04�2��25�32��03�'e�������U��S+C=SCCtsP�8���}<��b���� �6�      �      x������ � �      �   X   x�+�L���4202�50�50U04�20�2��344761�'e������������U��@c+S=3scC�e��q��qqq �c	      �   Z   x�+�L���4202�50�50U04�20�25�307220�'e������Y��[\���U��8K+c#=cC#�R�!�A���\1z\\\ Ġ�      �   Y   x�+�L���4202�50�50U04�24�22�3651�4�'e�������ϙ������i�U��83=s#Kcc�RP��`q��qqq �"e      �      x������ � �      �   `   x�+�L���4202�50�50U04�25�24�360054�'e�镟�X��������XY d9�&%����`"
E&��F& �a�+F��� ^%�      �      x������ � �      �   S   x�+�L���4202�50�50U04�22�20Գ022���'e������ə�����U��(K=c3s�R���!�`�+F��� gx�      �   �   x�3�,K��L.����s	�540�4202�tL.�,����	
��������<�a�����g
@�i E@�ƺ&��
�V��VF�z�@`b�O*���_!R�����ٟ�
NC#N4B�`�`�=... <U'S      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   y   x�+�L���4202�50�50U04�2��25�35�0���'eș����ǩb��bh�R��YbjT�^����Z���Q��Wf��f^�X���Ydj���b���� �-$h     