import multer from "multer"
import * as fs from 'fs';
const storage = multer.diskStorage({
   destination: function (req, file, cb) {
      const path = 'storage/vehiculos'
      try {
         fs.access(path, fs.constants.F_OK, (err => { //verificamos si existe la carpeta
            if (err) {
               // Create directory if directory does not exist.
               fs.mkdir(path, { recursive: true },
                  (err) => {
                     // console.log('Error', err)
                     if (err) {
                        console.log(`Error al crear el directorio: ${err}`)
                     } else {
                        console.log('Directorio ha sido creado .')
                     }
                     cb(null, path)
                  })
               cb(null, path)
            } else {
               cb(null, path)
            }
         }))
      } catch (error) {
         cb(null, path)
      }
   },
   filename: function (req, file, cb) {
      const array = file.originalname.split('.');
      const ext = array[array.length - 1];
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
      //Calling the callback passing the random name generated with the original extension name
      cb(null, 'file' + '-' + uniqueSuffix + '.' + ext);
   }
 })
 
 export const uploadMulter =(ubicacion:string)=> multer({ storage: storage,dest:ubicacion })