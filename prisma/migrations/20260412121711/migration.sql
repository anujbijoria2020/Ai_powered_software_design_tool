/*
  Warnings:

  - The values [ERD,SEQUENCE,CLASS,MINDMAP] on the enum `DiagramType` will be removed. If these variants are still used in the database, this will fail.
  - The values [SQL] on the enum `ExportFormat` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "DiagramType_new" AS ENUM ('SRS_DOCUMENT', 'CLASS_DIAGRAM', 'SEQUENCE_DIAGRAM', 'ENTITY_RELATIONSHIP_DIAGRAM', 'USE_CASE_DIAGRAM', 'FLOWCHART');
ALTER TABLE "artifacts" ALTER COLUMN "diagramType" TYPE "DiagramType_new" USING ("diagramType"::text::"DiagramType_new");
ALTER TYPE "DiagramType" RENAME TO "DiagramType_old";
ALTER TYPE "DiagramType_new" RENAME TO "DiagramType";
DROP TYPE "public"."DiagramType_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "ExportFormat_new" AS ENUM ('SVG', 'PNG', 'PDF');
ALTER TABLE "exports" ALTER COLUMN "format" TYPE "ExportFormat_new" USING ("format"::text::"ExportFormat_new");
ALTER TYPE "ExportFormat" RENAME TO "ExportFormat_old";
ALTER TYPE "ExportFormat_new" RENAME TO "ExportFormat";
DROP TYPE "public"."ExportFormat_old";
COMMIT;
