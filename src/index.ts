import app from "./app";
import { prisma } from "./config/prisma";

const PORT = process.env.PORT || 3000;

async function main() {
  // Test DB connection
  await prisma.$connect();
  console.log("✅ Database connected");

  app.listen(PORT, () => {
    console.log(`🚀 Server running on http://localhost:${PORT}`);
  });
}

main().catch(async (err) => {
  console.error("❌ Failed to start server:", err);
  await prisma.$disconnect();
  process.exit(1);
});