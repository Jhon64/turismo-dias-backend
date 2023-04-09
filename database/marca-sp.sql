create function get_marcas(req json) returns json
    language plpgsql
as
$$
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

----------------
create function post_add_marcas(req json) returns json
    language plpgsql
as
$$
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