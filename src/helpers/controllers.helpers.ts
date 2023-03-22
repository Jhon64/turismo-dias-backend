export interface IResponseController {
   statusCode: number;
   body: any;
   message: string;
 }
 
 export function makeController(
   code: number,
   data?: any,
   message?: any,
   isError?: boolean,
   log?: boolean
 ) {
   if (log) console.log("LOG::", { code, data });
   if (isError) {
     throw message;
   }
   const ret: IResponseController = {
     statusCode: code,
     body:
       typeof data == "string" ||
       typeof data == "number" ||
       typeof data == "boolean"
         ? data
         // : JSON.stringify(String(data || [{}])),
         :data || [{}],
     message: message,
   };
   return ret;
 }
 