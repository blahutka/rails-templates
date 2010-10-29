generate(:scaffold, "post", "title:string", "body:text")
generate(:scaffold, "price", "title:string", "body:text")

rake 'db:migrate'