using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace YourProject.Controllers  // đổi thành namespace thật của project bạn
{
    [ApiController]
    [Route("api/[controller]")]  // => route sẽ là /api/health
    public class HealthController : ControllerBase
    {
        private readonly LuanVanTotNghiep.backend.Models.Entities.AppDbContext _context; // đổi thành DbContext thật của bạn

        public HealthController(LuanVanTotNghiep.backend.Models.Entities.AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
                await _context.Database.ExecuteSqlRawAsync("SELECT 1");
                return Ok(new { status = "awake", time = DateTime.UtcNow });
            }
            catch
            {
                return StatusCode(503, new { status = "db unreachable" });
            }
        }
    }
}