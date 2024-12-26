using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace TaskService.Controllers
{
    public class EmployeeController : ApiController
    {

        public IEnumerable<Employee> Get() {
            using(Task_DBEntities dbContext = new Task_DBEntities())
            {
                return dbContext.Employees.ToList();
            }
        }
        public Employee Get(int id)
        {
            using(Task_DBEntities dbContext = new Task_DBEntities())
            {
                return dbContext.Employees.FirstOrDefault(e => e.id == id);
            }
        }

        public HttpResponseMessage Post([FromBody] Employee employee)
        {
            try
            {
                using (Task_DBEntities dbContext = new Task_DBEntities())
                {
                    dbContext.Employees.Add(employee);
                    dbContext.SaveChanges();
                    var message = Request.CreateResponse(HttpStatusCode.Created, employee);
                    message.Headers.Location = new Uri(Request.RequestUri +
                        employee.id.ToString());
                    return message;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
            }
        }

        public HttpResponseMessage Put(int id, [FromBody]Employee employee)
        {
            try
            {
                using (Task_DBEntities dbContext = new Task_DBEntities())
                {
                    var entity = dbContext.Employees.FirstOrDefault(e => e.id == id);
                    if (entity == null)
                    {
                        return Request.CreateErrorResponse(HttpStatusCode.NotFound,
                            "Employee with Id " + id.ToString() + " not found to update");
                    }
                    else
                    {
                        entity.name = employee.name;
                        entity.gender = employee.gender;
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
                    var entity = dbContext.Employees.FirstOrDefault(e => e.id == id);
                    if (entity == null)
                    {
                        return Request.CreateErrorResponse(HttpStatusCode.NotFound,
                            "Employee with Id = " + id.ToString() + " not found to delete");
                    }
                    else
                    {
                        dbContext.Employees.Remove(entity);
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
