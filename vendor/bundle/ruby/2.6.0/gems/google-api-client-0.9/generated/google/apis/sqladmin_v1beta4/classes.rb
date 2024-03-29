# Copyright 2015 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'date'
require 'google/apis/core/base_service'
require 'google/apis/core/json_representation'
require 'google/apis/core/hashable'
require 'google/apis/errors'

module Google
  module Apis
    module SqladminV1beta4
      
      # An entry for an Access Control list.
      class AclEntry
        include Google::Apis::Core::Hashable
      
        # The time when this access control entry expires in RFC 3339 format, for
        # example 2012-11-15T16:19:00.094Z.
        # Corresponds to the JSON property `expirationTime`
        # @return [DateTime]
        attr_accessor :expiration_time
      
        # This is always sql#aclEntry.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # An optional label to identify this entry.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # The whitelisted value for the access control list.
        # Corresponds to the JSON property `value`
        # @return [String]
        attr_accessor :value
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @expiration_time = args[:expiration_time] unless args[:expiration_time].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @name = args[:name] unless args[:name].nil?
          @value = args[:value] unless args[:value].nil?
        end
      end
      
      # Database instance backup configuration.
      class BackupConfiguration
        include Google::Apis::Core::Hashable
      
        # Whether binary log is enabled. If backup configuration is disabled, binary log
        # must be disabled as well.
        # Corresponds to the JSON property `binaryLogEnabled`
        # @return [Boolean]
        attr_accessor :binary_log_enabled
        alias_method :binary_log_enabled?, :binary_log_enabled
      
        # Whether this configuration is enabled.
        # Corresponds to the JSON property `enabled`
        # @return [Boolean]
        attr_accessor :enabled
        alias_method :enabled?, :enabled
      
        # This is always sql#backupConfiguration.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # Start time for the daily backup configuration in UTC timezone in the 24 hour
        # format - HH:MM.
        # Corresponds to the JSON property `startTime`
        # @return [String]
        attr_accessor :start_time
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @binary_log_enabled = args[:binary_log_enabled] unless args[:binary_log_enabled].nil?
          @enabled = args[:enabled] unless args[:enabled].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @start_time = args[:start_time] unless args[:start_time].nil?
        end
      end
      
      # A database instance backup run resource.
      class BackupRun
        include Google::Apis::Core::Hashable
      
        # The time the backup operation completed in UTC timezone in RFC 3339 format,
        # for example 2012-11-15T16:19:00.094Z.
        # Corresponds to the JSON property `endTime`
        # @return [DateTime]
        attr_accessor :end_time
      
        # The time the run was enqueued in UTC timezone in RFC 3339 format, for example
        # 2012-11-15T16:19:00.094Z.
        # Corresponds to the JSON property `enqueuedTime`
        # @return [DateTime]
        attr_accessor :enqueued_time
      
        # Database instance operation error.
        # Corresponds to the JSON property `error`
        # @return [Google::Apis::SqladminV1beta4::OperationError]
        attr_accessor :error
      
        # A unique identifier for this backup run. Note that this is unique only within
        # the scope of a particular Cloud SQL instance.
        # Corresponds to the JSON property `id`
        # @return [String]
        attr_accessor :id
      
        # Name of the database instance.
        # Corresponds to the JSON property `instance`
        # @return [String]
        attr_accessor :instance
      
        # This is always sql#backupRun.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The URI of this resource.
        # Corresponds to the JSON property `selfLink`
        # @return [String]
        attr_accessor :self_link
      
        # The time the backup operation actually started in UTC timezone in RFC 3339
        # format, for example 2012-11-15T16:19:00.094Z.
        # Corresponds to the JSON property `startTime`
        # @return [DateTime]
        attr_accessor :start_time
      
        # The status of this run.
        # Corresponds to the JSON property `status`
        # @return [String]
        attr_accessor :status
      
        # The start time of the backup window during which this the backup was attempted
        # in RFC 3339 format, for example 2012-11-15T16:19:00.094Z.
        # Corresponds to the JSON property `windowStartTime`
        # @return [DateTime]
        attr_accessor :window_start_time
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @end_time = args[:end_time] unless args[:end_time].nil?
          @enqueued_time = args[:enqueued_time] unless args[:enqueued_time].nil?
          @error = args[:error] unless args[:error].nil?
          @id = args[:id] unless args[:id].nil?
          @instance = args[:instance] unless args[:instance].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @self_link = args[:self_link] unless args[:self_link].nil?
          @start_time = args[:start_time] unless args[:start_time].nil?
          @status = args[:status] unless args[:status].nil?
          @window_start_time = args[:window_start_time] unless args[:window_start_time].nil?
        end
      end
      
      # Backup run list results.
      class ListBackupRunsResponse
        include Google::Apis::Core::Hashable
      
        # A list of backup runs in reverse chronological order of the enqueued time.
        # Corresponds to the JSON property `items`
        # @return [Array<Google::Apis::SqladminV1beta4::BackupRun>]
        attr_accessor :items
      
        # This is always sql#backupRunsList.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The continuation token, used to page through large result sets. Provide this
        # value in a subsequent request to return the next page of results.
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @items = args[:items] unless args[:items].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @next_page_token = args[:next_page_token] unless args[:next_page_token].nil?
        end
      end
      
      # Binary log coordinates.
      class BinLogCoordinates
        include Google::Apis::Core::Hashable
      
        # Name of the binary log file for a Cloud SQL instance.
        # Corresponds to the JSON property `binLogFileName`
        # @return [String]
        attr_accessor :bin_log_file_name
      
        # Position (offset) within the binary log file.
        # Corresponds to the JSON property `binLogPosition`
        # @return [String]
        attr_accessor :bin_log_position
      
        # This is always sql#binLogCoordinates.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @bin_log_file_name = args[:bin_log_file_name] unless args[:bin_log_file_name].nil?
          @bin_log_position = args[:bin_log_position] unless args[:bin_log_position].nil?
          @kind = args[:kind] unless args[:kind].nil?
        end
      end
      
      # Database instance clone context.
      class CloneContext
        include Google::Apis::Core::Hashable
      
        # Binary log coordinates.
        # Corresponds to the JSON property `binLogCoordinates`
        # @return [Google::Apis::SqladminV1beta4::BinLogCoordinates]
        attr_accessor :bin_log_coordinates
      
        # Name of the Cloud SQL instance to be created as a clone.
        # Corresponds to the JSON property `destinationInstanceName`
        # @return [String]
        attr_accessor :destination_instance_name
      
        # This is always sql#cloneContext.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @bin_log_coordinates = args[:bin_log_coordinates] unless args[:bin_log_coordinates].nil?
          @destination_instance_name = args[:destination_instance_name] unless args[:destination_instance_name].nil?
          @kind = args[:kind] unless args[:kind].nil?
        end
      end
      
      # A database resource inside a Cloud SQL instance.
      class Database
        include Google::Apis::Core::Hashable
      
        # The MySQL charset value.
        # Corresponds to the JSON property `charset`
        # @return [String]
        attr_accessor :charset
      
        # The MySQL collation value.
        # Corresponds to the JSON property `collation`
        # @return [String]
        attr_accessor :collation
      
        # HTTP 1.1 Entity tag for the resource.
        # Corresponds to the JSON property `etag`
        # @return [String]
        attr_accessor :etag
      
        # The name of the Cloud SQL instance. This does not include the project ID.
        # Corresponds to the JSON property `instance`
        # @return [String]
        attr_accessor :instance
      
        # This is always sql#database.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The name of the database in the Cloud SQL instance. This does not include the
        # project ID or instance name.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # The project ID of the project containing the Cloud SQL database. The Google
        # apps domain is prefixed if applicable.
        # Corresponds to the JSON property `project`
        # @return [String]
        attr_accessor :project
      
        # The URI of this resource.
        # Corresponds to the JSON property `selfLink`
        # @return [String]
        attr_accessor :self_link
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @charset = args[:charset] unless args[:charset].nil?
          @collation = args[:collation] unless args[:collation].nil?
          @etag = args[:etag] unless args[:etag].nil?
          @instance = args[:instance] unless args[:instance].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @name = args[:name] unless args[:name].nil?
          @project = args[:project] unless args[:project].nil?
          @self_link = args[:self_link] unless args[:self_link].nil?
        end
      end
      
      # MySQL flags for Cloud SQL instances.
      class DatabaseFlags
        include Google::Apis::Core::Hashable
      
        # The name of the flag. These flags are passed at instance startup, so include
        # both MySQL server options and MySQL system variables. Flags should be
        # specified with underscores, not hyphens. For more information, see Configuring
        # MySQL Flags in the Google Cloud SQL documentation, as well as the official
        # MySQL documentation for server options and system variables.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # The value of the flag. Booleans should be set to on for true and off for false.
        # This field must be omitted if the flag doesn't take a value.
        # Corresponds to the JSON property `value`
        # @return [String]
        attr_accessor :value
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @name = args[:name] unless args[:name].nil?
          @value = args[:value] unless args[:value].nil?
        end
      end
      
      # A Cloud SQL instance resource.
      class DatabaseInstance
        include Google::Apis::Core::Hashable
      
        # The current disk usage of the instance in bytes.
        # Corresponds to the JSON property `currentDiskSize`
        # @return [String]
        attr_accessor :current_disk_size
      
        # The database engine type and version. Can be MYSQL_5_5 or MYSQL_5_6. Defaults
        # to MYSQL_5_5. The databaseVersion can not be changed after instance creation.
        # Corresponds to the JSON property `databaseVersion`
        # @return [String]
        attr_accessor :database_version
      
        # HTTP 1.1 Entity tag for the resource.
        # Corresponds to the JSON property `etag`
        # @return [String]
        attr_accessor :etag
      
        # The name and status of the failover replica. Only applies to Second Generation
        # instances.
        # Corresponds to the JSON property `failoverReplica`
        # @return [Google::Apis::SqladminV1beta4::DatabaseInstance::FailoverReplica]
        attr_accessor :failover_replica
      
        # The instance type. This can be one of the following.
        # CLOUD_SQL_INSTANCE: A Cloud SQL instance that is not replicating from a master.
        # ON_PREMISES_INSTANCE: An instance running on the customer's premises.
        # READ_REPLICA_INSTANCE: A Cloud SQL instance configured as a read-replica.
        # Corresponds to the JSON property `instanceType`
        # @return [String]
        attr_accessor :instance_type
      
        # The assigned IP addresses for the instance.
        # Corresponds to the JSON property `ipAddresses`
        # @return [Array<Google::Apis::SqladminV1beta4::IpMapping>]
        attr_accessor :ip_addresses
      
        # The IPv6 address assigned to the instance.
        # Corresponds to the JSON property `ipv6Address`
        # @return [String]
        attr_accessor :ipv6_address
      
        # This is always sql#instance.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The name of the instance which will act as master in the replication setup.
        # Corresponds to the JSON property `masterInstanceName`
        # @return [String]
        attr_accessor :master_instance_name
      
        # The maximum disk size of the instance in bytes.
        # Corresponds to the JSON property `maxDiskSize`
        # @return [String]
        attr_accessor :max_disk_size
      
        # Name of the Cloud SQL instance. This does not include the project ID.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # On-premises instance configuration.
        # Corresponds to the JSON property `onPremisesConfiguration`
        # @return [Google::Apis::SqladminV1beta4::OnPremisesConfiguration]
        attr_accessor :on_premises_configuration
      
        # The project ID of the project containing the Cloud SQL instance. The Google
        # apps domain is prefixed if applicable.
        # Corresponds to the JSON property `project`
        # @return [String]
        attr_accessor :project
      
        # The geographical region. Can be us-central, asia-east1 or europe-west1.
        # Defaults to us-central. The region can not be changed after instance creation.
        # Corresponds to the JSON property `region`
        # @return [String]
        attr_accessor :region
      
        # Read-replica configuration for connecting to the master.
        # Corresponds to the JSON property `replicaConfiguration`
        # @return [Google::Apis::SqladminV1beta4::ReplicaConfiguration]
        attr_accessor :replica_configuration
      
        # The replicas of the instance.
        # Corresponds to the JSON property `replicaNames`
        # @return [Array<String>]
        attr_accessor :replica_names
      
        # The URI of this resource.
        # Corresponds to the JSON property `selfLink`
        # @return [String]
        attr_accessor :self_link
      
        # SslCerts Resource
        # Corresponds to the JSON property `serverCaCert`
        # @return [Google::Apis::SqladminV1beta4::SslCert]
        attr_accessor :server_ca_cert
      
        # The service account email address assigned to the instance.
        # Corresponds to the JSON property `serviceAccountEmailAddress`
        # @return [String]
        attr_accessor :service_account_email_address
      
        # Database instance settings.
        # Corresponds to the JSON property `settings`
        # @return [Google::Apis::SqladminV1beta4::Settings]
        attr_accessor :settings
      
        # The current serving state of the Cloud SQL instance. This can be one of the
        # following.
        # RUNNABLE: The instance is running, or is ready to run when accessed.
        # SUSPENDED: The instance is not available, for example due to problems with
        # billing.
        # PENDING_CREATE: The instance is being created.
        # MAINTENANCE: The instance is down for maintenance.
        # FAILED: The instance creation failed.
        # UNKNOWN_STATE: The state of the instance is unknown.
        # Corresponds to the JSON property `state`
        # @return [String]
        attr_accessor :state
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @current_disk_size = args[:current_disk_size] unless args[:current_disk_size].nil?
          @database_version = args[:database_version] unless args[:database_version].nil?
          @etag = args[:etag] unless args[:etag].nil?
          @failover_replica = args[:failover_replica] unless args[:failover_replica].nil?
          @instance_type = args[:instance_type] unless args[:instance_type].nil?
          @ip_addresses = args[:ip_addresses] unless args[:ip_addresses].nil?
          @ipv6_address = args[:ipv6_address] unless args[:ipv6_address].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @master_instance_name = args[:master_instance_name] unless args[:master_instance_name].nil?
          @max_disk_size = args[:max_disk_size] unless args[:max_disk_size].nil?
          @name = args[:name] unless args[:name].nil?
          @on_premises_configuration = args[:on_premises_configuration] unless args[:on_premises_configuration].nil?
          @project = args[:project] unless args[:project].nil?
          @region = args[:region] unless args[:region].nil?
          @replica_configuration = args[:replica_configuration] unless args[:replica_configuration].nil?
          @replica_names = args[:replica_names] unless args[:replica_names].nil?
          @self_link = args[:self_link] unless args[:self_link].nil?
          @server_ca_cert = args[:server_ca_cert] unless args[:server_ca_cert].nil?
          @service_account_email_address = args[:service_account_email_address] unless args[:service_account_email_address].nil?
          @settings = args[:settings] unless args[:settings].nil?
          @state = args[:state] unless args[:state].nil?
        end
        
        # The name and status of the failover replica. Only applies to Second Generation
        # instances.
        class FailoverReplica
          include Google::Apis::Core::Hashable
        
          # 
          # Corresponds to the JSON property `available`
          # @return [Boolean]
          attr_accessor :available
          alias_method :available?, :available
        
          # 
          # Corresponds to the JSON property `name`
          # @return [String]
          attr_accessor :name
        
          def initialize(**args)
             update!(**args)
          end
        
          # Update properties of this object
          def update!(**args)
            @available = args[:available] unless args[:available].nil?
            @name = args[:name] unless args[:name].nil?
          end
        end
      end
      
      # Database list response.
      class ListDatabasesResponse
        include Google::Apis::Core::Hashable
      
        # List of database resources in the instance.
        # Corresponds to the JSON property `items`
        # @return [Array<Google::Apis::SqladminV1beta4::Database>]
        attr_accessor :items
      
        # This is always sql#databasesList.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @items = args[:items] unless args[:items].nil?
          @kind = args[:kind] unless args[:kind].nil?
        end
      end
      
      # Database instance export context.
      class ExportContext
        include Google::Apis::Core::Hashable
      
        # Options for exporting data as CSV.
        # Corresponds to the JSON property `csvExportOptions`
        # @return [Google::Apis::SqladminV1beta4::ExportContext::CsvExportOptions]
        attr_accessor :csv_export_options
      
        # Databases (for example, guestbook) from which the export is made. If fileType
        # is SQL and no database is specified, all databases are exported. If fileType
        # is CSV, you can optionally specify at most one database to export. If
        # csvExportOptions.selectQuery also specifies the database, this field will be
        # ignored.
        # Corresponds to the JSON property `databases`
        # @return [Array<String>]
        attr_accessor :databases
      
        # The file type for the specified uri.
        # SQL: The file contains SQL statements.
        # CSV: The file contains CSV data.
        # Corresponds to the JSON property `fileType`
        # @return [String]
        attr_accessor :file_type
      
        # This is always sql#exportContext.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # Options for exporting data as SQL statements.
        # Corresponds to the JSON property `sqlExportOptions`
        # @return [Google::Apis::SqladminV1beta4::ExportContext::SqlExportOptions]
        attr_accessor :sql_export_options
      
        # The path to the file in Google Cloud Storage where the export will be stored.
        # The URI is in the form gs://bucketName/fileName. If the file already exists,
        # the operation fails. If fileType is SQL and the filename ends with .gz, the
        # contents are compressed.
        # Corresponds to the JSON property `uri`
        # @return [String]
        attr_accessor :uri
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @csv_export_options = args[:csv_export_options] unless args[:csv_export_options].nil?
          @databases = args[:databases] unless args[:databases].nil?
          @file_type = args[:file_type] unless args[:file_type].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @sql_export_options = args[:sql_export_options] unless args[:sql_export_options].nil?
          @uri = args[:uri] unless args[:uri].nil?
        end
        
        # Options for exporting data as CSV.
        class CsvExportOptions
          include Google::Apis::Core::Hashable
        
          # The select query used to extract the data.
          # Corresponds to the JSON property `selectQuery`
          # @return [String]
          attr_accessor :select_query
        
          def initialize(**args)
             update!(**args)
          end
        
          # Update properties of this object
          def update!(**args)
            @select_query = args[:select_query] unless args[:select_query].nil?
          end
        end
        
        # Options for exporting data as SQL statements.
        class SqlExportOptions
          include Google::Apis::Core::Hashable
        
          # Export only schemas.
          # Corresponds to the JSON property `schemaOnly`
          # @return [Boolean]
          attr_accessor :schema_only
          alias_method :schema_only?, :schema_only
        
          # Tables to export, or that were exported, from the specified database. If you
          # specify tables, specify one and only one database.
          # Corresponds to the JSON property `tables`
          # @return [Array<String>]
          attr_accessor :tables
        
          def initialize(**args)
             update!(**args)
          end
        
          # Update properties of this object
          def update!(**args)
            @schema_only = args[:schema_only] unless args[:schema_only].nil?
            @tables = args[:tables] unless args[:tables].nil?
          end
        end
      end
      
      # Database instance failover context.
      class FailoverContext
        include Google::Apis::Core::Hashable
      
        # This is always sql#failoverContext.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The current settings version of this instance. Request will be rejected if
        # this version doesn't match the current settings version.
        # Corresponds to the JSON property `settingsVersion`
        # @return [String]
        attr_accessor :settings_version
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @kind = args[:kind] unless args[:kind].nil?
          @settings_version = args[:settings_version] unless args[:settings_version].nil?
        end
      end
      
      # A Google Cloud SQL service flag resource.
      class Flag
        include Google::Apis::Core::Hashable
      
        # For STRING flags, a list of strings that the value can be set to.
        # Corresponds to the JSON property `allowedStringValues`
        # @return [Array<String>]
        attr_accessor :allowed_string_values
      
        # The database version this flag applies to. Can be MYSQL_5_5, MYSQL_5_6, or
        # both.
        # Corresponds to the JSON property `appliesTo`
        # @return [Array<String>]
        attr_accessor :applies_to
      
        # This is always sql#flag.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # For INTEGER flags, the maximum allowed value.
        # Corresponds to the JSON property `maxValue`
        # @return [String]
        attr_accessor :max_value
      
        # For INTEGER flags, the minimum allowed value.
        # Corresponds to the JSON property `minValue`
        # @return [String]
        attr_accessor :min_value
      
        # This is the name of the flag. Flag names always use underscores, not hyphens,
        # e.g. max_allowed_packet
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # Indicates whether changing this flag will trigger a database restart. Only
        # applicable to Second Generation instances.
        # Corresponds to the JSON property `requiresRestart`
        # @return [Boolean]
        attr_accessor :requires_restart
        alias_method :requires_restart?, :requires_restart
      
        # The type of the flag. Flags are typed to being BOOLEAN, STRING, INTEGER or
        # NONE. NONE is used for flags which do not take a value, such as
        # skip_grant_tables.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @allowed_string_values = args[:allowed_string_values] unless args[:allowed_string_values].nil?
          @applies_to = args[:applies_to] unless args[:applies_to].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @max_value = args[:max_value] unless args[:max_value].nil?
          @min_value = args[:min_value] unless args[:min_value].nil?
          @name = args[:name] unless args[:name].nil?
          @requires_restart = args[:requires_restart] unless args[:requires_restart].nil?
          @type = args[:type] unless args[:type].nil?
        end
      end
      
      # Flags list response.
      class ListFlagsResponse
        include Google::Apis::Core::Hashable
      
        # List of flags.
        # Corresponds to the JSON property `items`
        # @return [Array<Google::Apis::SqladminV1beta4::Flag>]
        attr_accessor :items
      
        # This is always sql#flagsList.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @items = args[:items] unless args[:items].nil?
          @kind = args[:kind] unless args[:kind].nil?
        end
      end
      
      # Database instance import context.
      class ImportContext
        include Google::Apis::Core::Hashable
      
        # Options for importing data as CSV.
        # Corresponds to the JSON property `csvImportOptions`
        # @return [Google::Apis::SqladminV1beta4::ImportContext::CsvImportOptions]
        attr_accessor :csv_import_options
      
        # The database (for example, guestbook) to which the import is made. If fileType
        # is SQL and no database is specified, it is assumed that the database is
        # specified in the file to be imported. If fileType is CSV, it must be specified.
        # Corresponds to the JSON property `database`
        # @return [String]
        attr_accessor :database
      
        # The file type for the specified uri.
        # SQL: The file contains SQL statements.
        # CSV: The file contains CSV data.
        # Corresponds to the JSON property `fileType`
        # @return [String]
        attr_accessor :file_type
      
        # This is always sql#importContext.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # A path to the file in Google Cloud Storage from which the import is made. The
        # URI is in the form gs://bucketName/fileName. Compressed gzip files (.gz) are
        # supported when fileType is SQL.
        # Corresponds to the JSON property `uri`
        # @return [String]
        attr_accessor :uri
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @csv_import_options = args[:csv_import_options] unless args[:csv_import_options].nil?
          @database = args[:database] unless args[:database].nil?
          @file_type = args[:file_type] unless args[:file_type].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @uri = args[:uri] unless args[:uri].nil?
        end
        
        # Options for importing data as CSV.
        class CsvImportOptions
          include Google::Apis::Core::Hashable
        
          # The columns to which CSV data is imported. If not specified, all columns of
          # the database table are loaded with CSV data.
          # Corresponds to the JSON property `columns`
          # @return [Array<String>]
          attr_accessor :columns
        
          # The table to which CSV data is imported.
          # Corresponds to the JSON property `table`
          # @return [String]
          attr_accessor :table
        
          def initialize(**args)
             update!(**args)
          end
        
          # Update properties of this object
          def update!(**args)
            @columns = args[:columns] unless args[:columns].nil?
            @table = args[:table] unless args[:table].nil?
          end
        end
      end
      
      # Database instance clone request.
      class CloneInstancesRequest
        include Google::Apis::Core::Hashable
      
        # Database instance clone context.
        # Corresponds to the JSON property `cloneContext`
        # @return [Google::Apis::SqladminV1beta4::CloneContext]
        attr_accessor :clone_context
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @clone_context = args[:clone_context] unless args[:clone_context].nil?
        end
      end
      
      # Database instance export request.
      class ExportInstancesRequest
        include Google::Apis::Core::Hashable
      
        # Database instance export context.
        # Corresponds to the JSON property `exportContext`
        # @return [Google::Apis::SqladminV1beta4::ExportContext]
        attr_accessor :export_context
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @export_context = args[:export_context] unless args[:export_context].nil?
        end
      end
      
      # Instance failover request.
      class InstancesFailoverRequest
        include Google::Apis::Core::Hashable
      
        # Database instance failover context.
        # Corresponds to the JSON property `failoverContext`
        # @return [Google::Apis::SqladminV1beta4::FailoverContext]
        attr_accessor :failover_context
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @failover_context = args[:failover_context] unless args[:failover_context].nil?
        end
      end
      
      # Database instance import request.
      class ImportInstancesRequest
        include Google::Apis::Core::Hashable
      
        # Database instance import context.
        # Corresponds to the JSON property `importContext`
        # @return [Google::Apis::SqladminV1beta4::ImportContext]
        attr_accessor :import_context
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @import_context = args[:import_context] unless args[:import_context].nil?
        end
      end
      
      # Database instances list response.
      class ListInstancesResponse
        include Google::Apis::Core::Hashable
      
        # List of database instance resources.
        # Corresponds to the JSON property `items`
        # @return [Array<Google::Apis::SqladminV1beta4::DatabaseInstance>]
        attr_accessor :items
      
        # This is always sql#instancesList.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The continuation token, used to page through large result sets. Provide this
        # value in a subsequent request to return the next page of results.
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @items = args[:items] unless args[:items].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @next_page_token = args[:next_page_token] unless args[:next_page_token].nil?
        end
      end
      
      # Database instance restore backup request.
      class RestoreInstancesBackupRequest
        include Google::Apis::Core::Hashable
      
        # Database instance restore from backup context.
        # Corresponds to the JSON property `restoreBackupContext`
        # @return [Google::Apis::SqladminV1beta4::RestoreBackupContext]
        attr_accessor :restore_backup_context
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @restore_backup_context = args[:restore_backup_context] unless args[:restore_backup_context].nil?
        end
      end
      
      # IP Management configuration.
      class IpConfiguration
        include Google::Apis::Core::Hashable
      
        # The list of external networks that are allowed to connect to the instance
        # using the IP. In CIDR notation, also known as 'slash' notation (e.g. 192.168.
        # 100.0/24).
        # Corresponds to the JSON property `authorizedNetworks`
        # @return [Array<Google::Apis::SqladminV1beta4::AclEntry>]
        attr_accessor :authorized_networks
      
        # Whether the instance should be assigned an IP address or not.
        # Corresponds to the JSON property `ipv4Enabled`
        # @return [Boolean]
        attr_accessor :ipv4_enabled
        alias_method :ipv4_enabled?, :ipv4_enabled
      
        # Whether the mysqld should default to 'REQUIRE X509' for users connecting over
        # IP.
        # Corresponds to the JSON property `requireSsl`
        # @return [Boolean]
        attr_accessor :require_ssl
        alias_method :require_ssl?, :require_ssl
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @authorized_networks = args[:authorized_networks] unless args[:authorized_networks].nil?
          @ipv4_enabled = args[:ipv4_enabled] unless args[:ipv4_enabled].nil?
          @require_ssl = args[:require_ssl] unless args[:require_ssl].nil?
        end
      end
      
      # Database instance IP Mapping.
      class IpMapping
        include Google::Apis::Core::Hashable
      
        # The IP address assigned.
        # Corresponds to the JSON property `ipAddress`
        # @return [String]
        attr_accessor :ip_address
      
        # The due time for this IP to be retired in RFC 3339 format, for example 2012-11-
        # 15T16:19:00.094Z. This field is only available when the IP is scheduled to be
        # retired.
        # Corresponds to the JSON property `timeToRetire`
        # @return [DateTime]
        attr_accessor :time_to_retire
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @ip_address = args[:ip_address] unless args[:ip_address].nil?
          @time_to_retire = args[:time_to_retire] unless args[:time_to_retire].nil?
        end
      end
      
      # Preferred location. This specifies where a Cloud SQL instance should
      # preferably be located, either in a specific Compute Engine zone, or co-located
      # with an App Engine application. Note that if the preferred location is not
      # available, the instance will be located as close as possible within the region.
      # Only one location may be specified.
      class LocationPreference
        include Google::Apis::Core::Hashable
      
        # The AppEngine application to follow, it must be in the same region as the
        # Cloud SQL instance.
        # Corresponds to the JSON property `followGaeApplication`
        # @return [String]
        attr_accessor :follow_gae_application
      
        # This is always sql#locationPreference.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The preferred Compute Engine zone (e.g. us-centra1-a, us-central1-b, etc.).
        # Corresponds to the JSON property `zone`
        # @return [String]
        attr_accessor :zone
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @follow_gae_application = args[:follow_gae_application] unless args[:follow_gae_application].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @zone = args[:zone] unless args[:zone].nil?
        end
      end
      
      # Maintenance window. This specifies when a v2 Cloud SQL instance should
      # preferably be restarted for system maintenance puruposes.
      class MaintenanceWindow
        include Google::Apis::Core::Hashable
      
        # day of week (1-7), starting on Monday.
        # Corresponds to the JSON property `day`
        # @return [Fixnum]
        attr_accessor :day
      
        # hour of day - 0 to 23.
        # Corresponds to the JSON property `hour`
        # @return [Fixnum]
        attr_accessor :hour
      
        # This is always sql#maintenanceWindow.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # 
        # Corresponds to the JSON property `updateTrack`
        # @return [String]
        attr_accessor :update_track
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @day = args[:day] unless args[:day].nil?
          @hour = args[:hour] unless args[:hour].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @update_track = args[:update_track] unless args[:update_track].nil?
        end
      end
      
      # Read-replica configuration specific to MySQL databases.
      class MySqlReplicaConfiguration
        include Google::Apis::Core::Hashable
      
        # PEM representation of the trusted CA's x509 certificate.
        # Corresponds to the JSON property `caCertificate`
        # @return [String]
        attr_accessor :ca_certificate
      
        # PEM representation of the slave's x509 certificate.
        # Corresponds to the JSON property `clientCertificate`
        # @return [String]
        attr_accessor :client_certificate
      
        # PEM representation of the slave's private key. The corresponsing public key is
        # encoded in the client's certificate.
        # Corresponds to the JSON property `clientKey`
        # @return [String]
        attr_accessor :client_key
      
        # Seconds to wait between connect retries. MySQL's default is 60 seconds.
        # Corresponds to the JSON property `connectRetryInterval`
        # @return [Fixnum]
        attr_accessor :connect_retry_interval
      
        # Path to a SQL dump file in Google Cloud Storage from which the slave instance
        # is to be created. The URI is in the form gs://bucketName/fileName. Compressed
        # gzip files (.gz) are also supported. Dumps should have the binlog co-ordinates
        # from which replication should begin. This can be accomplished by setting --
        # master-data to 1 when using mysqldump.
        # Corresponds to the JSON property `dumpFilePath`
        # @return [String]
        attr_accessor :dump_file_path
      
        # This is always sql#mysqlReplicaConfiguration.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # Interval in milliseconds between replication heartbeats.
        # Corresponds to the JSON property `masterHeartbeatPeriod`
        # @return [String]
        attr_accessor :master_heartbeat_period
      
        # The password for the replication connection.
        # Corresponds to the JSON property `password`
        # @return [String]
        attr_accessor :password
      
        # A list of permissible ciphers to use for SSL encryption.
        # Corresponds to the JSON property `sslCipher`
        # @return [String]
        attr_accessor :ssl_cipher
      
        # The username for the replication connection.
        # Corresponds to the JSON property `username`
        # @return [String]
        attr_accessor :username
      
        # Whether or not to check the master's Common Name value in the certificate that
        # it sends during the SSL handshake.
        # Corresponds to the JSON property `verifyServerCertificate`
        # @return [Boolean]
        attr_accessor :verify_server_certificate
        alias_method :verify_server_certificate?, :verify_server_certificate
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @ca_certificate = args[:ca_certificate] unless args[:ca_certificate].nil?
          @client_certificate = args[:client_certificate] unless args[:client_certificate].nil?
          @client_key = args[:client_key] unless args[:client_key].nil?
          @connect_retry_interval = args[:connect_retry_interval] unless args[:connect_retry_interval].nil?
          @dump_file_path = args[:dump_file_path] unless args[:dump_file_path].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @master_heartbeat_period = args[:master_heartbeat_period] unless args[:master_heartbeat_period].nil?
          @password = args[:password] unless args[:password].nil?
          @ssl_cipher = args[:ssl_cipher] unless args[:ssl_cipher].nil?
          @username = args[:username] unless args[:username].nil?
          @verify_server_certificate = args[:verify_server_certificate] unless args[:verify_server_certificate].nil?
        end
      end
      
      # On-premises instance configuration.
      class OnPremisesConfiguration
        include Google::Apis::Core::Hashable
      
        # The host and port of the on-premises instance in host:port format
        # Corresponds to the JSON property `hostPort`
        # @return [String]
        attr_accessor :host_port
      
        # This is always sql#onPremisesConfiguration.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @host_port = args[:host_port] unless args[:host_port].nil?
          @kind = args[:kind] unless args[:kind].nil?
        end
      end
      
      # An Operations resource contains information about database instance operations
      # such as create, delete, and restart. Operations resources are created in
      # response to operations that were initiated; you never create them directly.
      class Operation
        include Google::Apis::Core::Hashable
      
        # The time this operation finished in UTC timezone in RFC 3339 format, for
        # example 2012-11-15T16:19:00.094Z.
        # Corresponds to the JSON property `endTime`
        # @return [DateTime]
        attr_accessor :end_time
      
        # Database instance operation errors list wrapper.
        # Corresponds to the JSON property `error`
        # @return [Google::Apis::SqladminV1beta4::OperationErrors]
        attr_accessor :error
      
        # Database instance export context.
        # Corresponds to the JSON property `exportContext`
        # @return [Google::Apis::SqladminV1beta4::ExportContext]
        attr_accessor :export_context
      
        # Database instance import context.
        # Corresponds to the JSON property `importContext`
        # @return [Google::Apis::SqladminV1beta4::ImportContext]
        attr_accessor :import_context
      
        # The time this operation was enqueued in UTC timezone in RFC 3339 format, for
        # example 2012-11-15T16:19:00.094Z.
        # Corresponds to the JSON property `insertTime`
        # @return [DateTime]
        attr_accessor :insert_time
      
        # This is always sql#operation.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # An identifier that uniquely identifies the operation. You can use this
        # identifier to retrieve the Operations resource that has information about the
        # operation.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # The type of the operation. Valid values are CREATE, DELETE, UPDATE, RESTART,
        # IMPORT, EXPORT, BACKUP_VOLUME, RESTORE_VOLUME, CREATE_USER, DELETE_USER,
        # CREATE_DATABASE, DELETE_DATABASE .
        # Corresponds to the JSON property `operationType`
        # @return [String]
        attr_accessor :operation_type
      
        # The URI of this resource.
        # Corresponds to the JSON property `selfLink`
        # @return [String]
        attr_accessor :self_link
      
        # The time this operation actually started in UTC timezone in RFC 3339 format,
        # for example 2012-11-15T16:19:00.094Z.
        # Corresponds to the JSON property `startTime`
        # @return [DateTime]
        attr_accessor :start_time
      
        # The status of an operation. Valid values are PENDING, RUNNING, DONE, UNKNOWN.
        # Corresponds to the JSON property `status`
        # @return [String]
        attr_accessor :status
      
        # Name of the database instance related to this operation.
        # Corresponds to the JSON property `targetId`
        # @return [String]
        attr_accessor :target_id
      
        # The URI of the instance related to the operation.
        # Corresponds to the JSON property `targetLink`
        # @return [String]
        attr_accessor :target_link
      
        # The project ID of the target instance related to this operation.
        # Corresponds to the JSON property `targetProject`
        # @return [String]
        attr_accessor :target_project
      
        # The email address of the user who initiated this operation.
        # Corresponds to the JSON property `user`
        # @return [String]
        attr_accessor :user
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @end_time = args[:end_time] unless args[:end_time].nil?
          @error = args[:error] unless args[:error].nil?
          @export_context = args[:export_context] unless args[:export_context].nil?
          @import_context = args[:import_context] unless args[:import_context].nil?
          @insert_time = args[:insert_time] unless args[:insert_time].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @name = args[:name] unless args[:name].nil?
          @operation_type = args[:operation_type] unless args[:operation_type].nil?
          @self_link = args[:self_link] unless args[:self_link].nil?
          @start_time = args[:start_time] unless args[:start_time].nil?
          @status = args[:status] unless args[:status].nil?
          @target_id = args[:target_id] unless args[:target_id].nil?
          @target_link = args[:target_link] unless args[:target_link].nil?
          @target_project = args[:target_project] unless args[:target_project].nil?
          @user = args[:user] unless args[:user].nil?
        end
      end
      
      # Database instance operation error.
      class OperationError
        include Google::Apis::Core::Hashable
      
        # Identifies the specific error that occurred.
        # Corresponds to the JSON property `code`
        # @return [String]
        attr_accessor :code
      
        # This is always sql#operationError.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # Additional information about the error encountered.
        # Corresponds to the JSON property `message`
        # @return [String]
        attr_accessor :message
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @code = args[:code] unless args[:code].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @message = args[:message] unless args[:message].nil?
        end
      end
      
      # Database instance operation errors list wrapper.
      class OperationErrors
        include Google::Apis::Core::Hashable
      
        # The list of errors encountered while processing this operation.
        # Corresponds to the JSON property `errors`
        # @return [Array<Google::Apis::SqladminV1beta4::OperationError>]
        attr_accessor :errors
      
        # This is always sql#operationErrors.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @errors = args[:errors] unless args[:errors].nil?
          @kind = args[:kind] unless args[:kind].nil?
        end
      end
      
      # Database instance list operations response.
      class ListOperationsResponse
        include Google::Apis::Core::Hashable
      
        # List of operation resources.
        # Corresponds to the JSON property `items`
        # @return [Array<Google::Apis::SqladminV1beta4::Operation>]
        attr_accessor :items
      
        # This is always sql#operationsList.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The continuation token, used to page through large result sets. Provide this
        # value in a subsequent request to return the next page of results.
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @items = args[:items] unless args[:items].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @next_page_token = args[:next_page_token] unless args[:next_page_token].nil?
        end
      end
      
      # Read-replica configuration for connecting to the master.
      class ReplicaConfiguration
        include Google::Apis::Core::Hashable
      
        # Specifies if the replica is the failover target. If the field is set to true
        # the replica will be designated as a failover replica. In case the master
        # instance fails, the replica instance will be promoted as the new master
        # instance.
        # Only one replica can be specified as failover target, and the replica has to
        # be in different zone with the master instance.
        # Corresponds to the JSON property `failoverTarget`
        # @return [Boolean]
        attr_accessor :failover_target
        alias_method :failover_target?, :failover_target
      
        # This is always sql#replicaConfiguration.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # Read-replica configuration specific to MySQL databases.
        # Corresponds to the JSON property `mysqlReplicaConfiguration`
        # @return [Google::Apis::SqladminV1beta4::MySqlReplicaConfiguration]
        attr_accessor :mysql_replica_configuration
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @failover_target = args[:failover_target] unless args[:failover_target].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @mysql_replica_configuration = args[:mysql_replica_configuration] unless args[:mysql_replica_configuration].nil?
        end
      end
      
      # Database instance restore from backup context.
      class RestoreBackupContext
        include Google::Apis::Core::Hashable
      
        # The ID of the backup run to restore from.
        # Corresponds to the JSON property `backupRunId`
        # @return [String]
        attr_accessor :backup_run_id
      
        # The ID of the instance that the backup was taken from.
        # Corresponds to the JSON property `instanceId`
        # @return [String]
        attr_accessor :instance_id
      
        # This is always sql#restoreBackupContext.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @backup_run_id = args[:backup_run_id] unless args[:backup_run_id].nil?
          @instance_id = args[:instance_id] unless args[:instance_id].nil?
          @kind = args[:kind] unless args[:kind].nil?
        end
      end
      
      # Database instance settings.
      class Settings
        include Google::Apis::Core::Hashable
      
        # The activation policy for this instance. This specifies when the instance
        # should be activated and is applicable only when the instance state is RUNNABLE.
        # This can be one of the following.
        # ALWAYS: The instance should always be active.
        # NEVER: The instance should never be activated.
        # ON_DEMAND: The instance is activated upon receiving requests.
        # Corresponds to the JSON property `activationPolicy`
        # @return [String]
        attr_accessor :activation_policy
      
        # The App Engine app IDs that can access this instance.
        # Corresponds to the JSON property `authorizedGaeApplications`
        # @return [Array<String>]
        attr_accessor :authorized_gae_applications
      
        # Database instance backup configuration.
        # Corresponds to the JSON property `backupConfiguration`
        # @return [Google::Apis::SqladminV1beta4::BackupConfiguration]
        attr_accessor :backup_configuration
      
        # Configuration specific to read replica instances. Indicates whether database
        # flags for crash-safe replication are enabled.
        # Corresponds to the JSON property `crashSafeReplicationEnabled`
        # @return [Boolean]
        attr_accessor :crash_safe_replication_enabled
        alias_method :crash_safe_replication_enabled?, :crash_safe_replication_enabled
      
        # The size of data disk, in GB. Only supported for 2nd Generation instances. The
        # data disk size minimum is 10GB.
        # Corresponds to the JSON property `dataDiskSizeGb`
        # @return [String]
        attr_accessor :data_disk_size_gb
      
        # The type of data disk. Only supported for 2nd Generation instances. The
        # default type is SSD.
        # Corresponds to the JSON property `dataDiskType`
        # @return [String]
        attr_accessor :data_disk_type
      
        # The database flags passed to the instance at startup.
        # Corresponds to the JSON property `databaseFlags`
        # @return [Array<Google::Apis::SqladminV1beta4::DatabaseFlags>]
        attr_accessor :database_flags
      
        # Configuration specific to read replica instances. Indicates whether
        # replication is enabled or not.
        # Corresponds to the JSON property `databaseReplicationEnabled`
        # @return [Boolean]
        attr_accessor :database_replication_enabled
        alias_method :database_replication_enabled?, :database_replication_enabled
      
        # IP Management configuration.
        # Corresponds to the JSON property `ipConfiguration`
        # @return [Google::Apis::SqladminV1beta4::IpConfiguration]
        attr_accessor :ip_configuration
      
        # This is always sql#settings.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # Preferred location. This specifies where a Cloud SQL instance should
        # preferably be located, either in a specific Compute Engine zone, or co-located
        # with an App Engine application. Note that if the preferred location is not
        # available, the instance will be located as close as possible within the region.
        # Only one location may be specified.
        # Corresponds to the JSON property `locationPreference`
        # @return [Google::Apis::SqladminV1beta4::LocationPreference]
        attr_accessor :location_preference
      
        # Maintenance window. This specifies when a v2 Cloud SQL instance should
        # preferably be restarted for system maintenance puruposes.
        # Corresponds to the JSON property `maintenanceWindow`
        # @return [Google::Apis::SqladminV1beta4::MaintenanceWindow]
        attr_accessor :maintenance_window
      
        # The pricing plan for this instance. This can be either PER_USE or PACKAGE.
        # Corresponds to the JSON property `pricingPlan`
        # @return [String]
        attr_accessor :pricing_plan
      
        # The type of replication this instance uses. This can be either ASYNCHRONOUS or
        # SYNCHRONOUS.
        # Corresponds to the JSON property `replicationType`
        # @return [String]
        attr_accessor :replication_type
      
        # The version of instance settings. This is a required field for update method
        # to make sure concurrent updates are handled properly. During update, use the
        # most recent settingsVersion value for this instance and do not try to update
        # this value.
        # Corresponds to the JSON property `settingsVersion`
        # @return [String]
        attr_accessor :settings_version
      
        # The tier of service for this instance, for example D1, D2. For more
        # information, see pricing.
        # Corresponds to the JSON property `tier`
        # @return [String]
        attr_accessor :tier
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @activation_policy = args[:activation_policy] unless args[:activation_policy].nil?
          @authorized_gae_applications = args[:authorized_gae_applications] unless args[:authorized_gae_applications].nil?
          @backup_configuration = args[:backup_configuration] unless args[:backup_configuration].nil?
          @crash_safe_replication_enabled = args[:crash_safe_replication_enabled] unless args[:crash_safe_replication_enabled].nil?
          @data_disk_size_gb = args[:data_disk_size_gb] unless args[:data_disk_size_gb].nil?
          @data_disk_type = args[:data_disk_type] unless args[:data_disk_type].nil?
          @database_flags = args[:database_flags] unless args[:database_flags].nil?
          @database_replication_enabled = args[:database_replication_enabled] unless args[:database_replication_enabled].nil?
          @ip_configuration = args[:ip_configuration] unless args[:ip_configuration].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @location_preference = args[:location_preference] unless args[:location_preference].nil?
          @maintenance_window = args[:maintenance_window] unless args[:maintenance_window].nil?
          @pricing_plan = args[:pricing_plan] unless args[:pricing_plan].nil?
          @replication_type = args[:replication_type] unless args[:replication_type].nil?
          @settings_version = args[:settings_version] unless args[:settings_version].nil?
          @tier = args[:tier] unless args[:tier].nil?
        end
      end
      
      # SslCerts Resource
      class SslCert
        include Google::Apis::Core::Hashable
      
        # PEM representation.
        # Corresponds to the JSON property `cert`
        # @return [String]
        attr_accessor :cert
      
        # Serial number, as extracted from the certificate.
        # Corresponds to the JSON property `certSerialNumber`
        # @return [String]
        attr_accessor :cert_serial_number
      
        # User supplied name. Constrained to [a-zA-Z.-_ ]+.
        # Corresponds to the JSON property `commonName`
        # @return [String]
        attr_accessor :common_name
      
        # The time when the certificate was created in RFC 3339 format, for example 2012-
        # 11-15T16:19:00.094Z
        # Corresponds to the JSON property `createTime`
        # @return [DateTime]
        attr_accessor :create_time
      
        # The time when the certificate expires in RFC 3339 format, for example 2012-11-
        # 15T16:19:00.094Z.
        # Corresponds to the JSON property `expirationTime`
        # @return [DateTime]
        attr_accessor :expiration_time
      
        # Name of the database instance.
        # Corresponds to the JSON property `instance`
        # @return [String]
        attr_accessor :instance
      
        # This is always sql#sslCert.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The URI of this resource.
        # Corresponds to the JSON property `selfLink`
        # @return [String]
        attr_accessor :self_link
      
        # Sha1 Fingerprint.
        # Corresponds to the JSON property `sha1Fingerprint`
        # @return [String]
        attr_accessor :sha1_fingerprint
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @cert = args[:cert] unless args[:cert].nil?
          @cert_serial_number = args[:cert_serial_number] unless args[:cert_serial_number].nil?
          @common_name = args[:common_name] unless args[:common_name].nil?
          @create_time = args[:create_time] unless args[:create_time].nil?
          @expiration_time = args[:expiration_time] unless args[:expiration_time].nil?
          @instance = args[:instance] unless args[:instance].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @self_link = args[:self_link] unless args[:self_link].nil?
          @sha1_fingerprint = args[:sha1_fingerprint] unless args[:sha1_fingerprint].nil?
        end
      end
      
      # SslCertDetail.
      class SslCertDetail
        include Google::Apis::Core::Hashable
      
        # SslCerts Resource
        # Corresponds to the JSON property `certInfo`
        # @return [Google::Apis::SqladminV1beta4::SslCert]
        attr_accessor :cert_info
      
        # The private key for the client cert, in pem format. Keep private in order to
        # protect your security.
        # Corresponds to the JSON property `certPrivateKey`
        # @return [String]
        attr_accessor :cert_private_key
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @cert_info = args[:cert_info] unless args[:cert_info].nil?
          @cert_private_key = args[:cert_private_key] unless args[:cert_private_key].nil?
        end
      end
      
      # SslCerts create ephemeral certificate request.
      class SslCertsCreateEphemeralRequest
        include Google::Apis::Core::Hashable
      
        # PEM encoded public key to include in the signed certificate.
        # Corresponds to the JSON property `public_key`
        # @return [String]
        attr_accessor :public_key
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @public_key = args[:public_key] unless args[:public_key].nil?
        end
      end
      
      # SslCerts insert request.
      class InsertSslCertsRequest
        include Google::Apis::Core::Hashable
      
        # User supplied name. Must be a distinct name from the other certificates for
        # this instance. New certificates will not be usable until the instance is
        # restarted.
        # Corresponds to the JSON property `commonName`
        # @return [String]
        attr_accessor :common_name
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @common_name = args[:common_name] unless args[:common_name].nil?
        end
      end
      
      # SslCert insert response.
      class InsertSslCertsResponse
        include Google::Apis::Core::Hashable
      
        # SslCertDetail.
        # Corresponds to the JSON property `clientCert`
        # @return [Google::Apis::SqladminV1beta4::SslCertDetail]
        attr_accessor :client_cert
      
        # This is always sql#sslCertsInsert.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # SslCerts Resource
        # Corresponds to the JSON property `serverCaCert`
        # @return [Google::Apis::SqladminV1beta4::SslCert]
        attr_accessor :server_ca_cert
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @client_cert = args[:client_cert] unless args[:client_cert].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @server_ca_cert = args[:server_ca_cert] unless args[:server_ca_cert].nil?
        end
      end
      
      # SslCerts list response.
      class ListSslCertsResponse
        include Google::Apis::Core::Hashable
      
        # List of client certificates for the instance.
        # Corresponds to the JSON property `items`
        # @return [Array<Google::Apis::SqladminV1beta4::SslCert>]
        attr_accessor :items
      
        # This is always sql#sslCertsList.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @items = args[:items] unless args[:items].nil?
          @kind = args[:kind] unless args[:kind].nil?
        end
      end
      
      # A Google Cloud SQL service tier resource.
      class Tier
        include Google::Apis::Core::Hashable
      
        # The maximum disk size of this tier in bytes.
        # Corresponds to the JSON property `DiskQuota`
        # @return [String]
        attr_accessor :disk_quota
      
        # The maximum RAM usage of this tier in bytes.
        # Corresponds to the JSON property `RAM`
        # @return [String]
        attr_accessor :ram
      
        # This is always sql#tier.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The applicable regions for this tier. Can be us-east1, europe-west1 or asia-
        # east1.
        # Corresponds to the JSON property `region`
        # @return [Array<String>]
        attr_accessor :region
      
        # An identifier for the service tier, for example D1, D2 etc. For related
        # information, see Pricing.
        # Corresponds to the JSON property `tier`
        # @return [String]
        attr_accessor :tier
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @disk_quota = args[:disk_quota] unless args[:disk_quota].nil?
          @ram = args[:ram] unless args[:ram].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @region = args[:region] unless args[:region].nil?
          @tier = args[:tier] unless args[:tier].nil?
        end
      end
      
      # Tiers list response.
      class ListTiersResponse
        include Google::Apis::Core::Hashable
      
        # List of tiers.
        # Corresponds to the JSON property `items`
        # @return [Array<Google::Apis::SqladminV1beta4::Tier>]
        attr_accessor :items
      
        # This is always sql#tiersList.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @items = args[:items] unless args[:items].nil?
          @kind = args[:kind] unless args[:kind].nil?
        end
      end
      
      # A Cloud SQL user resource.
      class User
        include Google::Apis::Core::Hashable
      
        # HTTP 1.1 Entity tag for the resource.
        # Corresponds to the JSON property `etag`
        # @return [String]
        attr_accessor :etag
      
        # The host name from which the user can connect. For insert operations, host
        # defaults to an empty string. For update operations, host is specified as part
        # of the request URL. The host name is not mutable with this API.
        # Corresponds to the JSON property `host`
        # @return [String]
        attr_accessor :host
      
        # The name of the Cloud SQL instance. This does not include the project ID. Can
        # be omitted for update since it is already specified on the URL.
        # Corresponds to the JSON property `instance`
        # @return [String]
        attr_accessor :instance
      
        # This is always sql#user.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # The name of the user in the Cloud SQL instance. Can be omitted for update
        # since it is already specified on the URL.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # The password for the user.
        # Corresponds to the JSON property `password`
        # @return [String]
        attr_accessor :password
      
        # The project ID of the project containing the Cloud SQL database. The Google
        # apps domain is prefixed if applicable. Can be omitted for update since it is
        # already specified on the URL.
        # Corresponds to the JSON property `project`
        # @return [String]
        attr_accessor :project
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @etag = args[:etag] unless args[:etag].nil?
          @host = args[:host] unless args[:host].nil?
          @instance = args[:instance] unless args[:instance].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @name = args[:name] unless args[:name].nil?
          @password = args[:password] unless args[:password].nil?
          @project = args[:project] unless args[:project].nil?
        end
      end
      
      # User list response.
      class ListUsersResponse
        include Google::Apis::Core::Hashable
      
        # List of user resources in the instance.
        # Corresponds to the JSON property `items`
        # @return [Array<Google::Apis::SqladminV1beta4::User>]
        attr_accessor :items
      
        # This is always sql#usersList.
        # Corresponds to the JSON property `kind`
        # @return [String]
        attr_accessor :kind
      
        # An identifier that uniquely identifies the operation. You can use this
        # identifier to retrieve the Operations resource that has information about the
        # operation.
        # Corresponds to the JSON property `nextPageToken`
        # @return [String]
        attr_accessor :next_page_token
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @items = args[:items] unless args[:items].nil?
          @kind = args[:kind] unless args[:kind].nil?
          @next_page_token = args[:next_page_token] unless args[:next_page_token].nil?
        end
      end
    end
  end
end
