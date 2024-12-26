using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace TaskService.Controllers
{
    public class TaskController : ApiController
    {
        public IEnumerable<Task> Get()
        {
            using (Task_DBEntities dbContext = new Task_DBEntities())
            {
                return dbContext.Tasks.ToList();
            }
        }
        public Task Get(int id)
        {
            using (Task_DBEntities dbContext = new Task_DBEntities())
            {
                return dbContext.Tasks.FirstOrDefault(e => e.id == id);
            }
        }

        public HttpResponseMessage Post([FromBody] Task Task)
        {
            try
            {
                using (Task_DBEntities dbContext = new Task_DBEntities())
                {
                    dbContext.Tasks.Add(Task);
                    dbContext.SaveChanges();
                    var message = Request.CreateResponse(HttpStatusCode.Created, Task);
                    message.Headers.Location = new Uri(Request.RequestUri +
                        Task.id.ToString());
                    return message;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
            }
        }

        public HttpResponseMessage Put(int id, [FromBody]Task Task)
        {
            try
            {
                using (Task_DBEntities dbContext = new Task_DBEntities())
                {
                    var entity = dbContext.Tasks.FirstOrDefault(e => e.id == id);
                    if (entity == null)
                    {
                        return Request.CreateErrorResponse(HttpStatusCode.NotFound,
                            "Task with Id " + id.ToString() + " not found to update");
                    }
                    else
                    {
                        entity.TaskName = Task.TaskName;
                        entity.TaskDescription = Task.TaskDescription;
                        entity.EmployeeName = Task.EmployeeName;
                        dbContext.SaveChanges();
                        return Request.CreateResponse(HttpStatusCode.OK, entity);
                    }
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
            }
        }

        public HttpResponseMessage Delete(int id)
        {
            try
            {
                using (Task_DBEntities dbContext = new Task_DBEntities())
                {
                    var entity = dbContext.Tasks.FirstOrDefault(e => e.id == id);
                    if (entity == null)
                    {
                        return Request.CreateErrorResponse(HttpStatusCode.NotFound,
                            "Task with Id = " + id.ToString() + " not found to delete");
                    }
                    else
                    {
                        dbContext.Tasks.Remove(entity);
                        dbContext.SaveChanges();
                        return Request.CreateResponse(HttpStatusCode.OK);
                    }
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
            }
        }
    }
}
