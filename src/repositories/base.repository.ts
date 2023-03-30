import { TypeORMSource } from './../database/typeorm';
import { PG } from './../database/pg';
import { QueryResult } from 'pg';
export interface IPgResult {
   error?: any,
   result?: any
}
export class BaseRepository{
   protected db
   protected pg
   constructor() {
      this.db = TypeORMSource.getInstance.dbConnection;
      this.pg = new PG().getConnection
   }
   
   async execProcedure(procedureName: string, args: any[]): Promise<IPgResult> {
      if (args && !Array.isArray(args)) args = [args]
      let args1 = ''
      const finalArgs = []
      // console.log('argumentos::',args)
      for (let i = 0; i < args.length; i++) {
          let arg = args[i]
          // console.log('iterando argumento::',arg)
          finalArgs.push(arg)
          if (!args1) {
              args1 += `$1`
          } else {
              args1 += `, $${i + 1}`
          }
      }
      const h = ['SELECT', '*', 'FROM'].join(' ')
      const funcToExec = `${h} ${procedureName}(${args1}) as output`
    //   console.log('Ejecutando función ::', funcToExec)
      let queryResult: QueryResult

      const startTime = Date.now()
      try {
          queryResult = await (await this.pg).query(funcToExec, finalArgs)
      } catch (error: any) {
          error = String(error)
        //   console.log('error al ejecutar sp')
          throw error
      }

      let result = queryResult.rows[0].output
      // Si es un objeto que debe convertirse en un array
      if (result && !Array.isArray(result) && typeof result.A !== undefined) {
          result = Object.values(result)
      }
    //   console.log('datos obtenidos', result)
      return {result}
  }
}