-- Users table
CREATE TABLE User (
    UserID VARCHAR PRIMARY KEY,
    FirstName VARCHAR,
    LastName VARCHAR,
    Email VARCHAR,
    PasswordHash VARCHAR,
    RegistrationDate TIMESTAMP,
    LastLoginDate TIMESTAMP,
    VerificationStatus VARCHAR
);

-- Startup Ideas
CREATE TABLE StartupIdea (
    IdeaID VARCHAR PRIMARY KEY,
    FounderUserID VARCHAR REFERENCES User(UserID),
    IdeaName VARCHAR,
    ElevatorPitch TEXT,
    ProblemStatement TEXT,
    SolutionDescription TEXT,
    TargetAudience TEXT,
    MarketSize_Notes TEXT,
    Competitors_Notes TEXT,
    CreationDate TIMESTAMP,
    LastModifiedDate TIMESTAMP,
    Status VARCHAR
);

-- Customer Value Proposition (CVP)
CREATE TABLE CVP (
    CVP_ID VARCHAR PRIMARY KEY,
    IdeaID VARCHAR REFERENCES StartupIdea(IdeaID),
    VersionNumber INTEGER,
    CustomerSegments_Desc TEXT,
    ValuePropositions_Desc TEXT,
    Channels_Desc TEXT,
    CustomerRelationships_Desc TEXT,
    RevenueStreams_Desc TEXT,
    KeyActivities_Desc TEXT,
    KeyResources_Desc TEXT,
    KeyPartnerships_Desc TEXT,
    CostStructure_Desc TEXT,
    RefinementDate TIMESTAMP,
    IsCurrent BOOLEAN
);

-- Hypotheses
CREATE TABLE Hypothesis (
    HypothesisID VARCHAR PRIMARY KEY,
    IdeaID VARCHAR REFERENCES StartupIdea(IdeaID),
    AssumptionText TEXT,
    ValidationMethod_Desc VARCHAR,
    Status VARCHAR,
    EvidenceSummary TEXT,
    CreationDate TIMESTAMP
);

-- Surveys
CREATE TABLE Survey (
    SurveyID VARCHAR PRIMARY KEY,
    IdeaID VARCHAR REFERENCES StartupIdea(IdeaID),
    PrimaryHypothesisID VARCHAR REFERENCES Hypothesis(HypothesisID),
    Title VARCHAR,
    Description TEXT,
    GeneratedScript_JSON JSON,
    ShareableLink VARCHAR,
    Status VARCHAR,
    CreationDate TIMESTAMP,
    LaunchDate TIMESTAMP,
    CloseDate TIMESTAMP
);

-- Feedback files
CREATE TABLE FeedbackFile (
    FileID VARCHAR PRIMARY KEY,
    IdeaID VARCHAR REFERENCES StartupIdea(IdeaID),
    SurveyID VARCHAR REFERENCES Survey(SurveyID),
    OriginalFileName VARCHAR,
    StoredFilePath VARCHAR,
    FileType VARCHAR,
    UploadDate TIMESTAMP,
    Notes TEXT
);

-- Feedback Insights
CREATE TABLE FeedbackInsight (
    InsightID VARCHAR PRIMARY KEY,
    IdeaID VARCHAR REFERENCES StartupIdea(IdeaID),
    SourceFileID VARCHAR REFERENCES FeedbackFile(FileID),
    SourceSurveyID VARCHAR REFERENCES Survey(SurveyID),
    InsightType VARCHAR,
    InsightValue TEXT,
    Details TEXT,
    SentimentScore FLOAT,
    AnalysisDate TIMESTAMP
);

-- Pitch Deck Templates
CREATE TABLE PitchDeckTemplate (
    TemplateID VARCHAR PRIMARY KEY,
    TemplateName VARCHAR,
    Description TEXT,
    StructureDefinition_JSON JSON,
    IsActive BOOLEAN
);

-- Pitch Decks
CREATE TABLE PitchDeck (
    PitchDeckID VARCHAR PRIMARY KEY,
    IdeaID VARCHAR REFERENCES StartupIdea(IdeaID),
    TemplateID VARCHAR REFERENCES PitchDeckTemplate(TemplateID),
    VersionNumber INTEGER,
    GeneratedContent_JSON JSON,
    FinalFilePath VARCHAR,
    CreationDate TIMESTAMP,
    LastModifiedDate TIMESTAMP,
    SharingLink VARCHAR
);