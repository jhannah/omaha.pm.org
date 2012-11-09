##---- CursorTypeEnum Values ----
$adOpenForwardOnly = 0;
$adOpenKeyset = 1;
$adOpenDynamic = 2;
$adOpenStatic = 3;

##---- CursorOptionEnum Values ----
$adHoldRecords = 0x00000100;
$adMovePrevious = 0x00000200;
$adAddNew = 0x01000400;
$adDelete = 0x01000800;
$adUpdate = 0x01008000;
$adBookmark = 0x00002000;
$adApproxPosition = 0x00004000;
$adUpdateBatch = 0x00010000;
$adResync = 0x00020000;
$adNotify = 0x00040000;

##---- LockTypeEnum Values ----
$adLockReadOnly = 1;
$adLockPessimistic = 2;
$adLockOptimistic = 3;
$adLockBatchOptimistic = 4;

##---- ExecuteOptionEnum Values ----
$adRunAsync = 0x00000010;

##---- ObjectStateEnum Values ----
$adStateClosed = 0x00000000;
$adStateOpen = 0x00000001;
$adStateConnecting = 0x00000002;
$adStateExecuting = 0x00000004;

##---- CursorLocationEnum Values ----
$adUseServer = 2;
$adUseClient = 3;

##---- DataTypeEnum Values ----
$adEmpty = 0;
$adTinyInt = 16;
$adSmallInt = 2;
$adInteger = 3;
$adBigInt = 20;
$adUnsignedTinyInt = 17;
$adUnsignedSmallInt = 18;
$adUnsignedInt = 19;
$adUnsignedBigInt = 21;
$adSingle = 4;
$adDouble = 5;
$adCurrency = 6;
$adDecimal = 14;
$adNumeric = 131;
$adBoolean = 11;
$adError = 10;
$adUserDefined = 132;
$adVariant = 12;
$adIDispatch = 9;
$adIUnknown = 13;
$adGUID = 72;
$adDate = 7;
$adDBDate = 133;
$adDBTime = 134;
$adDBTimeStamp = 135;
$adBSTR = 8;
$adChar = 129;
$adVarChar = 200;
$adLongVarChar = 201;
$adWChar = 130;
$adVarWChar = 202;
$adLongVarWChar = 203;
$adBinary = 128;
$adVarBinary = 204;
$adLongVarBinary = 205;

##---- FieldAttributeEnum Values ----
$adFldMayDefer = 0x00000002;
$adFldUpdatable = 0x00000004;
$adFldUnknownUpdatable = 0x00000008;
$adFldFixed = 0x00000010;
$adFldIsNullable = 0x00000020;
$adFldMayBeNull = 0x00000040;
$adFldLong = 0x00000080;
$adFldRowID = 0x00000100;
$adFldRowVersion = 0x00000200;
$adFldCacheDeferred = 0x00001000;

##---- EditModeEnum Values ----
$adEditNone = 0x0000;
$adEditInProgress = 0x0001;
$adEditAdd = 0x0002;
$adEditDelete = 0x0004;

##---- RecordStatusEnum Values ----
$adRecOK = 0x0000000;
$adRecNew = 0x0000001;
$adRecModified = 0x0000002;
$adRecDeleted = 0x0000004;
$adRecUnmodified = 0x0000008;
$adRecInvalid = 0x0000010;
$adRecMultipleChanges = 0x0000040;
$adRecPendingChanges = 0x0000080;
$adRecCanceled = 0x0000100;
$adRecCantRelease = 0x0000400;
$adRecConcurrencyViolation = 0x0000800;
$adRecIntegrityViolation = 0x0001000;
$adRecMaxChangesExceeded = 0x0002000;
$adRecObjectOpen = 0x0004000;
$adRecOutOfMemory = 0x0008000;
$adRecPermissionDenied = 0x0010000;
$adRecSchemaViolation = 0x0020000;
$adRecDBDeleted = 0x0040000;

##---- GetRowsOptionEnum Values ----
$adGetRowsRest = -1;

##---- PositionEnum Values ----
$adPosUnknown = -1;
$adPosBOF = -2;
$adPosEOF = -3;

##---- enum Values ----
$adBookmarkCurrent = 0;
$adBookmarkFirst = 1;
$adBookmarkLast = 2;

##---- MarshalOptionsEnum Values ----
$adMarshalAll = 0;
$adMarshalModifiedOnly = 1;

##---- AffectEnum Values ----
$adAffectCurrent = 1;
$adAffectGroup = 2;
$adAffectAll = 3;

##---- FilterGroupEnum Values ----
$adFilterNone = 0;
$adFilterPendingRecords = 1;
$adFilterAffectedRecords = 2;
$adFilterFetchedRecords = 3;
$adFilterPredicate = 4;

##---- SearchDirection Values ----
$adSearchForward = 0;
$adSearchBackward = 1;

##---- ConnectPromptEnum Values ----
$adPromptAlways = 1;
$adPromptComplete = 2;
$adPromptCompleteRequired = 3;
$adPromptNever = 4;

##---- ConnectModeEnum Values ----
$adModeUnknown = 0;
$adModeRead = 1;
$adModeWrite = 2;
$adModeReadWrite = 3;
$adModeShareDenyRead = 4;
$adModeShareDenyWrite = 8;
$adModeShareExclusive = 0xc;
$adModeShareDenyNone = 0x10;

##---- IsolationLevelEnum Values ----
$adXactUnspecified = 0xffffffff;
$adXactChaos = 0x00000010;
$adXactReadUncommitted = 0x00000100;
$adXactBrowse = 0x00000100;
$adXactCursorStability = 0x00001000;
$adXactReadCommitted = 0x00001000;
$adXactRepeatableRead = 0x00010000;
$adXactSerializable = 0x00100000;
$adXactIsolated = 0x00100000;

##---- XactAttributeEnum Values ----
$adXactCommitRetaining = 0x00020000;
$adXactAbortRetaining = 0x00040000;

##---- PropertyAttributesEnum Values ----
$adPropNotSupported = 0x0000;
$adPropRequired = 0x0001;
$adPropOptional = 0x0002;
$adPropRead = 0x0200;
$adPropWrite = 0x0400;

##---- ErrorValueEnum Values ----
$adErrInvalidArgument = 0xbb9;
$adErrNoCurrentRecord = 0xbcd;
$adErrIllegalOperation = 0xc93;
$adErrInTransaction = 0xcae;
$adErrFeatureNotAvailable = 0xcb3;
$adErrItemNotFound = 0xcc1;
$adErrObjectInCollection = 0xd27;
$adErrObjectNotSet = 0xd5c;
$adErrDataConversion = 0xd5d;
$adErrObjectClosed = 0xe78;
$adErrObjectOpen = 0xe79;
$adErrProviderNotFound = 0xe7a;
$adErrBoundToCommand = 0xe7b;
$adErrInvalidParamInfo = 0xe7c;
$adErrInvalidConnection = 0xe7d;
$adErrStillExecuting = 0xe7f;
$adErrStillConnecting = 0xe81;

##---- ParameterAttributesEnum Values ----
$adParamSigned = 0x0010;
$adParamNullable = 0x0040;
$adParamLong = 0x0080;

##---- ParameterDirectionEnum Values ----
$adParamUnknown = 0x0000;
$adParamInput = 0x0001;
$adParamOutput = 0x0002;
$adParamInputOutput = 0x0003;
$adParamReturnValue = 0x0004;

##---- CommandTypeEnum Values ----
$adCmdUnknown = 0x0008;
$adCmdText = 0x0001;
$adCmdTable = 0x0002;
$adCmdStoredProc = 0x0004;

##---- SchemaEnum Values ----
$adSchemaProviderSpecific = -1;
$adSchemaAsserts = 0;
$adSchemaCatalogs = 1;
$adSchemaCharacterSets = 2;
$adSchemaCollations = 3;
$adSchemaColumns = 4;
$adSchemaCheckConstraints = 5;
$adSchemaConstraintColumnUsage = 6;
$adSchemaConstraintTableUsage = 7;
$adSchemaKeyColumnUsage = 8;
$adSchemaReferentialContraints = 9;
$adSchemaTableConstraints = 10;
$adSchemaColumnsDomainUsage = 11;
$adSchemaIndexes = 12;
$adSchemaColumnPrivileges = 13;
$adSchemaTablePrivileges = 14;
$adSchemaUsagePrivileges = 15;
$adSchemaProcedures = 16;
$adSchemaSchemata = 17;
$adSchemaSQLLanguages = 18;
$adSchemaStatistics = 19;
$adSchemaTables = 20;
$adSchemaTranslations = 21;
$adSchemaProviderTypes = 22;
$adSchemaViews = 23;
$adSchemaViewColumnUsage = 24;
$adSchemaViewTableUsage = 25;
$adSchemaProcedureParameters = 26;
$adSchemaForeignKeys = 27;
$adSchemaPrimaryKeys = 28;
$adSchemaProcedureColumns = 29;

