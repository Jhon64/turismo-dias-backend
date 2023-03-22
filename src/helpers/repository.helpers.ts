export interface IResponseRepository {
   status:boolean|'OK'|'ERROR';
   statusCode?: number;
   data?: any;
   message?: string;
   error?:any
 }
 