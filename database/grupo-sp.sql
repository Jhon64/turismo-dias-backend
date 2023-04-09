create function get_grupos(req json) returns json
    language plpgsql
as
$$
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

--------------------

create function post_add_grupo(req json) returns json
    language plpgsql
as
$$
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