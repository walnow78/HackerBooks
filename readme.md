## HackerBooks

** ¿En que se distingue isKindOfClass de isMemberOfClass?** 

El método *isKindOfClass* devuelve YES cuando el objeto es o hereda de la clase indicada
El método *isMemberOfClass* devuelve YES cuando el objeto es de la clase indicada

**¿Donde guardarías las imagenes de la portada y los datos?**

Todos estos datos los guardo en la Sandbox en la carpeta caches porque son recuperables en caso de que sean borrados.

**¿Como harías que la información persista?**

La persistencia la estoy haciendo mediante NSUserDefault guardando el titulo del libro en el caso que el usuario lo marque como favorito y borrandolo cuando lo desmarca. Otra forma podría ser serializar y guardar el JSON. Lo estoy haciendo con NSUserDefault porque es poca información que estoy guardando y me parece que es más rápido.

**¿Como enviarías información de AGTBook a AGTLibraryTAbleViewController?**

Lo que he hecho es mediante delegados en el momento que el usuario cambia un libro como favorito, mediante target/action aviso al controlados del viewcontroller. Este avisa mediante el delegado al modelo library y por último el modelo library avisa a tableviewcontroller del cambio del modelo para que refresque lo datos.

Otra forma de hacerlo podría ser mediante notificaciones. 

Estoy usando la forma de delegado porque según lo explicado el orden es target/action, delegado y notificaciones. Al poder implementar el delegado, lo estoy usando.

**¿Es una aberración volver a cargar todos los datos si la mayoría de los datos son correctos al cambiar un libro a favorito?**

No es una aberración porque tableviewcontroller solamente pedirá información de las celdas que está mostrando en este momento por lo que no cargará más de 10 celdas.

**Cuando el usuario cambia en la tabla el libro seleccionado, el AGTSiemplePDFViewController debe de actualizarse, ¿Como lo harías?**

Lo estoy haciendo mediante notificaciones porque del tableviewcontroller depende tanto el bookviewcontroller como pdfviewcontroller así que lanzo la notificación desde tableviewcontroller y suscribo los viewcontrollers

