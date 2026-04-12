-- CreateIndex
CREATE INDEX "artifacts_requirementId_idx" ON "artifacts"("requirementId");

-- CreateIndex
CREATE INDEX "artifacts_status_idx" ON "artifacts"("status");

-- CreateIndex
CREATE INDEX "artifacts_diagramType_idx" ON "artifacts"("diagramType");

-- CreateIndex
CREATE INDEX "artifacts_status_diagramType_idx" ON "artifacts"("status", "diagramType");

-- CreateIndex
CREATE INDEX "artifacts_createdAt_idx" ON "artifacts"("createdAt");

-- CreateIndex
CREATE INDEX "collaborators_userId_idx" ON "collaborators"("userId");

-- CreateIndex
CREATE INDEX "collaborators_projectId_role_idx" ON "collaborators"("projectId", "role");

-- CreateIndex
CREATE INDEX "exports_artifactId_idx" ON "exports"("artifactId");

-- CreateIndex
CREATE INDEX "exports_format_idx" ON "exports"("format");

-- CreateIndex
CREATE INDEX "projects_ownerId_idx" ON "projects"("ownerId");

-- CreateIndex
CREATE INDEX "projects_name_idx" ON "projects"("name");

-- CreateIndex
CREATE INDEX "projects_createdAt_idx" ON "projects"("createdAt");

-- CreateIndex
CREATE INDEX "requirements_projectId_idx" ON "requirements"("projectId");

-- CreateIndex
CREATE INDEX "requirements_createdAt_idx" ON "requirements"("createdAt");

-- CreateIndex
CREATE INDEX "users_name_idx" ON "users"("name");
