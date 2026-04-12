/*
  Warnings:

  - The values [SRS_DOCUMENT,CLASS_DIAGRAM,SEQUENCE_DIAGRAM,ENTITY_RELATIONSHIP_DIAGRAM,USE_CASE_DIAGRAM,FLOWCHART] on the enum `DiagramType` will be removed. If these variants are still used in the database, this will fail.
  - The values [SVG,PNG,PDF] on the enum `ExportFormat` will be removed. If these variants are still used in the database, this will fail.
  - The primary key for the `artifacts` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `createdAt` on the `artifacts` table. All the data in the column will be lost.
  - You are about to drop the column `diagramType` on the `artifacts` table. All the data in the column will be lost.
  - You are about to drop the column `errorMessage` on the `artifacts` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `artifacts` table. All the data in the column will be lost.
  - You are about to drop the column `jobId` on the `artifacts` table. All the data in the column will be lost.
  - You are about to drop the column `requirementId` on the `artifacts` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `artifacts` table. All the data in the column will be lost.
  - You are about to drop the column `svgContent` on the `artifacts` table. All the data in the column will be lost.
  - You are about to drop the column `syntax` on the `artifacts` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `artifacts` table. All the data in the column will be lost.
  - The primary key for the `exports` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `artifactId` on the `exports` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `exports` table. All the data in the column will be lost.
  - You are about to drop the column `fileUrl` on the `exports` table. All the data in the column will be lost.
  - You are about to drop the column `format` on the `exports` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `exports` table. All the data in the column will be lost.
  - The primary key for the `projects` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `createdAt` on the `projects` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `projects` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `projects` table. All the data in the column will be lost.
  - You are about to drop the column `ownerId` on the `projects` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `projects` table. All the data in the column will be lost.
  - The primary key for the `requirements` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `createdAt` on the `requirements` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `requirements` table. All the data in the column will be lost.
  - You are about to drop the column `projectId` on the `requirements` table. All the data in the column will be lost.
  - You are about to drop the column `rawText` on the `requirements` table. All the data in the column will be lost.
  - You are about to drop the column `refinedText` on the `requirements` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `requirements` table. All the data in the column will be lost.
  - The primary key for the `users` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `avatarUrl` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `password` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `users` table. All the data in the column will be lost.
  - You are about to drop the `collaborators` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[username]` on the table `users` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `artifact_type` to the `artifacts` table without a default value. This is not possible if the table is not empty.
  - Added the required column `generated_by` to the `artifacts` table without a default value. This is not possible if the table is not empty.
  - Added the required column `project_id` to the `artifacts` table without a default value. This is not possible if the table is not empty.
  - Added the required column `artifact_id` to the `exports` table without a default value. This is not possible if the table is not empty.
  - Added the required column `export_format` to the `exports` table without a default value. This is not possible if the table is not empty.
  - Added the required column `owner_id` to the `projects` table without a default value. This is not possible if the table is not empty.
  - Added the required column `project_name` to the `projects` table without a default value. This is not possible if the table is not empty.
  - Added the required column `project_id` to the `requirements` table without a default value. This is not possible if the table is not empty.
  - Added the required column `title` to the `requirements` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password_hash` to the `users` table without a default value. This is not possible if the table is not empty.
  - Added the required column `username` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Role" AS ENUM ('admin', 'user');

-- CreateEnum
CREATE TYPE "ProjectStatus" AS ENUM ('active', 'archived');

-- CreateEnum
CREATE TYPE "AccessLevel" AS ENUM ('viewer', 'editor', 'manager');

-- CreateEnum
CREATE TYPE "Priority" AS ENUM ('high', 'medium', 'low');

-- CreateEnum
CREATE TYPE "ArtifactType" AS ENUM ('document', 'diagram');

-- CreateEnum
CREATE TYPE "DocumentFormat" AS ENUM ('docx', 'pdf');

-- AlterEnum
BEGIN;
CREATE TYPE "DiagramType_new" AS ENUM ('UML', 'ER', 'flowchart', 'sequence', 'class', 'other');
ALTER TABLE "artifacts" ALTER COLUMN "diagramType" TYPE "DiagramType_new" USING ("diagramType"::text::"DiagramType_new");
ALTER TYPE "DiagramType" RENAME TO "DiagramType_old";
ALTER TYPE "DiagramType_new" RENAME TO "DiagramType";
DROP TYPE "public"."DiagramType_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "ExportFormat_new" AS ENUM ('docx', 'pdf', 'png', 'sql');
ALTER TABLE "exports" ALTER COLUMN "format" TYPE "ExportFormat_new" USING ("format"::text::"ExportFormat_new");
ALTER TYPE "ExportFormat" RENAME TO "ExportFormat_old";
ALTER TYPE "ExportFormat_new" RENAME TO "ExportFormat";
DROP TYPE "public"."ExportFormat_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "artifacts" DROP CONSTRAINT "artifacts_requirementId_fkey";

-- DropForeignKey
ALTER TABLE "collaborators" DROP CONSTRAINT "collaborators_projectId_fkey";

-- DropForeignKey
ALTER TABLE "collaborators" DROP CONSTRAINT "collaborators_userId_fkey";

-- DropForeignKey
ALTER TABLE "exports" DROP CONSTRAINT "exports_artifactId_fkey";

-- DropForeignKey
ALTER TABLE "projects" DROP CONSTRAINT "projects_ownerId_fkey";

-- DropForeignKey
ALTER TABLE "requirements" DROP CONSTRAINT "requirements_projectId_fkey";

-- DropIndex
DROP INDEX "artifacts_createdAt_idx";

-- DropIndex
DROP INDEX "artifacts_diagramType_idx";

-- DropIndex
DROP INDEX "artifacts_jobId_key";

-- DropIndex
DROP INDEX "artifacts_requirementId_idx";

-- DropIndex
DROP INDEX "artifacts_status_diagramType_idx";

-- DropIndex
DROP INDEX "artifacts_status_idx";

-- DropIndex
DROP INDEX "exports_artifactId_idx";

-- DropIndex
DROP INDEX "exports_format_idx";

-- DropIndex
DROP INDEX "projects_createdAt_idx";

-- DropIndex
DROP INDEX "projects_name_idx";

-- DropIndex
DROP INDEX "projects_ownerId_idx";

-- DropIndex
DROP INDEX "requirements_createdAt_idx";

-- DropIndex
DROP INDEX "requirements_projectId_idx";

-- DropIndex
DROP INDEX "users_name_idx";

-- AlterTable
ALTER TABLE "artifacts" DROP CONSTRAINT "artifacts_pkey",
DROP COLUMN "createdAt",
DROP COLUMN "diagramType",
DROP COLUMN "errorMessage",
DROP COLUMN "id",
DROP COLUMN "jobId",
DROP COLUMN "requirementId",
DROP COLUMN "status",
DROP COLUMN "svgContent",
DROP COLUMN "syntax",
DROP COLUMN "updatedAt",
ADD COLUMN     "artifact_id" SERIAL NOT NULL,
ADD COLUMN     "artifact_type" "ArtifactType" NOT NULL,
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "generated_by" INTEGER NOT NULL,
ADD COLUMN     "project_id" INTEGER NOT NULL,
ADD CONSTRAINT "artifacts_pkey" PRIMARY KEY ("artifact_id");

-- AlterTable
ALTER TABLE "exports" DROP CONSTRAINT "exports_pkey",
DROP COLUMN "artifactId",
DROP COLUMN "createdAt",
DROP COLUMN "fileUrl",
DROP COLUMN "format",
DROP COLUMN "id",
ADD COLUMN     "artifact_id" INTEGER NOT NULL,
ADD COLUMN     "export_format" "ExportFormat" NOT NULL,
ADD COLUMN     "export_id" SERIAL NOT NULL,
ADD COLUMN     "exported_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD CONSTRAINT "exports_pkey" PRIMARY KEY ("export_id");

-- AlterTable
ALTER TABLE "projects" DROP CONSTRAINT "projects_pkey",
DROP COLUMN "createdAt",
DROP COLUMN "id",
DROP COLUMN "name",
DROP COLUMN "ownerId",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "owner_id" INTEGER NOT NULL,
ADD COLUMN     "project_id" SERIAL NOT NULL,
ADD COLUMN     "project_name" TEXT NOT NULL,
ADD COLUMN     "status" "ProjectStatus" NOT NULL DEFAULT 'active',
ADD CONSTRAINT "projects_pkey" PRIMARY KEY ("project_id");

-- AlterTable
ALTER TABLE "requirements" DROP CONSTRAINT "requirements_pkey",
DROP COLUMN "createdAt",
DROP COLUMN "id",
DROP COLUMN "projectId",
DROP COLUMN "rawText",
DROP COLUMN "refinedText",
DROP COLUMN "updatedAt",
ADD COLUMN     "description" TEXT,
ADD COLUMN     "priority" "Priority" NOT NULL DEFAULT 'medium',
ADD COLUMN     "project_id" INTEGER NOT NULL,
ADD COLUMN     "requirement_id" SERIAL NOT NULL,
ADD COLUMN     "title" TEXT NOT NULL,
ADD CONSTRAINT "requirements_pkey" PRIMARY KEY ("requirement_id");

-- AlterTable
ALTER TABLE "users" DROP CONSTRAINT "users_pkey",
DROP COLUMN "avatarUrl",
DROP COLUMN "createdAt",
DROP COLUMN "id",
DROP COLUMN "name",
DROP COLUMN "password",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "password_hash" TEXT NOT NULL,
ADD COLUMN     "role" "Role" NOT NULL DEFAULT 'user',
ADD COLUMN     "user_id" SERIAL NOT NULL,
ADD COLUMN     "username" TEXT NOT NULL,
ADD CONSTRAINT "users_pkey" PRIMARY KEY ("user_id");

-- DropTable
DROP TABLE "collaborators";

-- DropEnum
DROP TYPE "ArtifactStatus";

-- DropEnum
DROP TYPE "CollaboratorRole";

-- CreateTable
CREATE TABLE "project_members" (
    "member_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "project_id" INTEGER NOT NULL,
    "accessLevel" "AccessLevel" NOT NULL DEFAULT 'viewer',
    "joined_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "project_members_pkey" PRIMARY KEY ("member_id")
);

-- CreateTable
CREATE TABLE "documents" (
    "document_id" SERIAL NOT NULL,
    "artifact_id" INTEGER NOT NULL,
    "document_format" "DocumentFormat" NOT NULL,

    CONSTRAINT "documents_pkey" PRIMARY KEY ("document_id")
);

-- CreateTable
CREATE TABLE "diagrams" (
    "diagram_id" SERIAL NOT NULL,
    "artifact_id" INTEGER NOT NULL,
    "diagram_type" "DiagramType" NOT NULL,

    CONSTRAINT "diagrams_pkey" PRIMARY KEY ("diagram_id")
);

-- CreateTable
CREATE TABLE "versions" (
    "version_id" SERIAL NOT NULL,
    "artifact_id" INTEGER NOT NULL,
    "version_number" TEXT NOT NULL,
    "change_summary" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "versions_pkey" PRIMARY KEY ("version_id")
);

-- CreateTable
CREATE TABLE "sdlc_models" (
    "sdlc_id" SERIAL NOT NULL,
    "model_name" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "sdlc_models_pkey" PRIMARY KEY ("sdlc_id")
);

-- CreateTable
CREATE TABLE "project_sdlc" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "sdlc_id" INTEGER NOT NULL,
    "confidence_score" DOUBLE PRECISION,

    CONSTRAINT "project_sdlc_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "feasibility_reports" (
    "report_id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "technical_score" DOUBLE PRECISION,
    "economic_score" DOUBLE PRECISION,
    "operational_score" DOUBLE PRECISION,
    "final_decision" TEXT,

    CONSTRAINT "feasibility_reports_pkey" PRIMARY KEY ("report_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "project_members_user_id_project_id_key" ON "project_members"("user_id", "project_id");

-- CreateIndex
CREATE UNIQUE INDEX "documents_artifact_id_key" ON "documents"("artifact_id");

-- CreateIndex
CREATE UNIQUE INDEX "diagrams_artifact_id_key" ON "diagrams"("artifact_id");

-- CreateIndex
CREATE UNIQUE INDEX "sdlc_models_model_name_key" ON "sdlc_models"("model_name");

-- CreateIndex
CREATE UNIQUE INDEX "project_sdlc_project_id_sdlc_id_key" ON "project_sdlc"("project_id", "sdlc_id");

-- CreateIndex
CREATE UNIQUE INDEX "feasibility_reports_project_id_key" ON "feasibility_reports"("project_id");

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- AddForeignKey
ALTER TABLE "projects" ADD CONSTRAINT "projects_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_members" ADD CONSTRAINT "project_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_members" ADD CONSTRAINT "project_members_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "projects"("project_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "requirements" ADD CONSTRAINT "requirements_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "projects"("project_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "artifacts" ADD CONSTRAINT "artifacts_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "projects"("project_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "artifacts" ADD CONSTRAINT "artifacts_generated_by_fkey" FOREIGN KEY ("generated_by") REFERENCES "users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_artifact_id_fkey" FOREIGN KEY ("artifact_id") REFERENCES "artifacts"("artifact_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "diagrams" ADD CONSTRAINT "diagrams_artifact_id_fkey" FOREIGN KEY ("artifact_id") REFERENCES "artifacts"("artifact_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "versions" ADD CONSTRAINT "versions_artifact_id_fkey" FOREIGN KEY ("artifact_id") REFERENCES "artifacts"("artifact_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exports" ADD CONSTRAINT "exports_artifact_id_fkey" FOREIGN KEY ("artifact_id") REFERENCES "artifacts"("artifact_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_sdlc" ADD CONSTRAINT "project_sdlc_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "projects"("project_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_sdlc" ADD CONSTRAINT "project_sdlc_sdlc_id_fkey" FOREIGN KEY ("sdlc_id") REFERENCES "sdlc_models"("sdlc_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feasibility_reports" ADD CONSTRAINT "feasibility_reports_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "projects"("project_id") ON DELETE RESTRICT ON UPDATE CASCADE;
