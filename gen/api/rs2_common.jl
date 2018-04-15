# Automatically generated using Clang.jl wrap_c, version 0.0.0

const STDepthControlGroup = Void
const STRsm = Void
const STRauSupportVectorControl = Void
const STColorControl = Void
const STRauColorThresholdsControl = Void
const STSloColorThresholdsControl = Void
const STSloPenaltyControl = Void
const STHdad = Void
const STColorCorrection = Void
const STAEControl = Void
const STDepthTableControl = Void
const STCensusRadius = Void

@cenum(rs2_timestamp_domain,
    RS2_TIMESTAMP_DOMAIN_HARDWARE_CLOCK = 0,
    RS2_TIMESTAMP_DOMAIN_SYSTEM_TIME = 1,
    RS2_TIMESTAMP_DOMAIN_COUNT = 2,
)

@cenum(rs2_frame_metadata_value,
    RS2_FRAME_METADATA_FRAME_TIMESTAMP = 1,
	RS2_FRAME_METADATA_SENSOR_TIMESTAMP = 2,
	RS2_FRAME_METADATA_ACTUAL_EXPOSURE = 3,
	RS2_FRAME_METADATA_GAIN_LEVEL = 4,
	RS2_FRAME_METADATA_AUTO_EXPOSURE = 5,
	RS2_FRAME_METADATA_WHITE_BALANCE = 6,
	RS2_FRAME_METADATA_TIME_OF_ARRIVAL = 7,
	RS2_FRAME_METADATA_TEMPERATURE = 8,
	RS2_FRAME_METADATA_BACKEND_TIMESTAMP = 9,
    RS2_FRAME_METADATA_ACTUAL_FPS = 10,
    RS2_FRAME_METADATA_COUNT = 11,
)

struct rs2_vertex
    xyz::NTuple{3, Cfloat}
end

struct rs2_pixel
    ij::NTuple{2, Cint}
end

struct rs2_vector
    x::Cfloat
    y::Cfloat
    z::Cfloat
end

struct rs2_quaternion
    x::Cfloat
    y::Cfloat
    z::Cfloat
    w::Cfloat
end

struct rs2_pose
    translation::rs2_vector
    velocity::rs2_vector
    acceleration::rs2_vector
    rotation::rs2_quaternion
    angular_velocity::rs2_vector
    angular_acceleration::rs2_vector
    tracker_confidence::UInt32
    mapper_confidence::UInt32
end

@cenum(rs2_option,
	RS2_OPTION_BACKLIGHT_COMPENSATION = 0,
	RS2_OPTION_BRIGHTNESS = 1,
	RS2_OPTION_CONTRAST = 2,
	RS2_OPTION_EXPOSURE = 3,
	RS2_OPTION_GAIN = 4,
	RS2_OPTION_GAMMA = 5,
	RS2_OPTION_HUE = 6,
	RS2_OPTION_SATURATION = 7,
	RS2_OPTION_SHARPNESS = 8,
	RS2_OPTION_WHITE_BALANCE = 9,
    RS2_OPTION_ENABLE_AUTO_EXPOSURE = 10,
	RS2_OPTION_ENABLE_AUTO_WHITE_BALANCE = 11,
	RS2_OPTION_VISUAL_PRESET = 12,
	RS2_OPTION_LASER_POWER = 13,
	RS2_OPTION_ACCURACY = 14,
	RS2_OPTION_MOTION_RANGE = 15,
	RS2_OPTION_FILTER_OPTION = 16,
	RS2_OPTION_CONFIDENCE_THRESHOLD = 17,
	RS2_OPTION_EMITTER_ENABLED = 18,
	RS2_OPTION_FRAMES_QUEUE_SIZE = 19,
	RS2_OPTION_TOTAL_FRAME_DROPS = 20,
	RS2_OPTION_AUTO_EXPOSURE_MODE = 21,
	RS2_OPTION_POWER_LINE_FREQUENCY = 22,
	RS2_OPTION_ASIC_TEMPERATURE = 23,
	RS2_OPTION_ERROR_POLLING_ENABLED = 24,
	RS2_OPTION_PROJECTOR_TEMPERATURE = 25,
	RS2_OPTION_OUTPUT_TRIGGER_ENABLED = 26,
	RS2_OPTION_MOTION_MODULE_TEMPERATURE = 27,
	RS2_OPTION_DEPTH_UNITS = 28,
	RS2_OPTION_ENABLE_MOTION_CORRECTION = 29,
	RS2_OPTION_AUTO_EXPOSURE_PRIORITY = 30,
	RS2_OPTION_COLOR_SCHEME = 31,
	RS2_OPTION_HISTOGRAM_EQUALIZATION_ENABLED = 32,
	RS2_OPTION_MIN_DISTANCE = 33,
	RS2_OPTION_MAX_DISTANCE = 34,
	RS2_OPTION_TEXTURE_SOURCE = 35,
	RS2_OPTION_FILTER_MAGNITUDE = 36,
	RS2_OPTION_FILTER_SMOOTH_ALPHA = 37,
	RS2_OPTION_FILTER_SMOOTH_DELTA = 38,
	RS2_OPTION_HOLES_FILL = 39,
	RS2_OPTION_STEREO_BASELINE = 40,
	RS2_OPTION_AUTO_EXPOSURE_CONVERGE_STEP = 41,
	RS2_OPTION_COUNT = 42,
)

@cenum(rs2_sr300_visual_preset,
	RS2_SR300_VISUAL_PRESET_SHORT_RANGE = 0,
	RS2_SR300_VISUAL_PRESET_LONG_RANGE = 1,
	RS2_SR300_VISUAL_PRESET_BACKGROUND_SEGMENTATION = 2,
	RS2_SR300_VISUAL_PRESET_GESTURE_RECOGNITION = 3,
	RS2_SR300_VISUAL_PRESET_OBJECT_SCANNING = 4,
	RS2_SR300_VISUAL_PRESET_FACE_ANALYTICS = 5,
	RS2_SR300_VISUAL_PRESET_FACE_LOGIN = 6,
	RS2_SR300_VISUAL_PRESET_GR_CURSOR = 7,
	RS2_SR300_VISUAL_PRESET_DEFAULT = 8,
	RS2_SR300_VISUAL_PRESET_MID_RANGE = 9,
	RS2_SR300_VISUAL_PRESET_IR_ONLY = 10,
	RS2_SR300_VISUAL_PRESET_COUNT = 11,
)

@cenum(rs2_rs400_visual_preset,
	RS2_RS400_VISUAL_PRESET_CUSTOM = 0,
	RS2_RS400_VISUAL_PRESET_DEFAULT = 1,
	RS2_RS400_VISUAL_PRESET_HAND = 2,
	RS2_RS400_VISUAL_PRESET_HIGH_ACCURACY = 3,
	RS2_RS400_VISUAL_PRESET_HIGH_DENSITY = 4,
	RS2_RS400_VISUAL_PRESET_MEDIUM_DENSITY = 5,
	RS2_RS400_VISUAL_PRESET_COUNT = 6,
)

@cenum(rs2_playback_status,
	RS2_PLAYBACK_STATUS_UNKNOWN = 0,
	RS2_PLAYBACK_STATUS_PLAYING = 1,
	RS2_PLAYBACK_STATUS_PAUSED = 2,
	RS2_PLAYBACK_STATUS_STOPPED = 3,
	RS2_PLAYBACK_STATUS_COUNT = 4,
)

const rs2_playback_status_changed_callback_ptr = Ptr{Void}

@cenum(rs2_camera_info,
	RS2_CAMERA_INFO_NAME = 0,
	RS2_CAMERA_INFO_SERIAL_NUMBER = 1,
	RS2_CAMERA_INFO_FIRMWARE_VERSION = 2,
	RS2_CAMERA_INFO_PHYSICAL_PORT = 3,
	RS2_CAMERA_INFO_DEBUG_OP_CODE = 4,
	RS2_CAMERA_INFO_ADVANCED_MODE = 5,
	RS2_CAMERA_INFO_PRODUCT_ID = 6,
	RS2_CAMERA_INFO_CAMERA_LOCKED = 7,
	RS2_CAMERA_INFO_COUNT = 8,
)

@cenum(rs2_stream,
	RS2_STREAM_ANY = 0,
	RS2_STREAM_DEPTH = 1,
	RS2_STREAM_COLOR = 2,
	RS2_STREAM_INFRARED = 3,
	RS2_STREAM_FISHEYE = 4,
	RS2_STREAM_GYRO = 5,
	RS2_STREAM_ACCEL = 6,
	RS2_STREAM_GPIO = 7,
	RS2_STREAM_POSE = 8,
	RS2_STREAM_COUNT = 9,
)

@cenum(rs2_format,
	RS2_FORMAT_ANY = 0,
	RS2_FORMAT_Z16 = 1,
	RS2_FORMAT_DISPARITY16 = 2,
	RS2_FORMAT_XYZ32F = 3,
	RS2_FORMAT_YUYV = 4,
	RS2_FORMAT_RGB8 = 5,
	RS2_FORMAT_BGR8 = 6,
	RS2_FORMAT_RGBA8 = 7,
	RS2_FORMAT_BGRA8 = 8,
	RS2_FORMAT_Y8 = 9,
	RS2_FORMAT_Y16 = 10,
	RS2_FORMAT_RAW10 = 11,
	RS2_FORMAT_RAW16 = 12,
	RS2_FORMAT_RAW8 = 13,
	RS2_FORMAT_UYVY = 14,
	RS2_FORMAT_MOTION_RAW = 15,
	RS2_FORMAT_MOTION_XYZ32F = 16,
	RS2_FORMAT_GPIO_RAW = 17,
	RS2_FORMAT_6DOF = 18,
	RS2_FORMAT_DISPARITY32 = 19,
	RS2_FORMAT_COUNT = 20,
)

struct rs2_extrinsics
    rotation::NTuple{9, Cfloat}
    translation::NTuple{3, Cfloat}
end

@cenum(rs2_notification_category,
	RS2_NOTIFICATION_CATEGORY_FRAMES_TIMEOUT = 0,
	RS2_NOTIFICATION_CATEGORY_FRAME_CORRUPTED = 1,
	RS2_NOTIFICATION_CATEGORY_HARDWARE_ERROR = 2,
	RS2_NOTIFICATION_CATEGORY_HARDWARE_EVENT = 3,
	RS2_NOTIFICATION_CATEGORY_UNKNOWN_ERROR = 4,
	RS2_NOTIFICATION_CATEGORY_COUNT = 5,
)

@cenum(rs2_exception_type,
	RS2_EXCEPTION_TYPE_UNKNOWN = 0,
	RS2_EXCEPTION_TYPE_CAMERA_DISCONNECTED = 1,
	RS2_EXCEPTION_TYPE_BACKEND = 2,
	RS2_EXCEPTION_TYPE_INVALID_VALUE = 3,
	RS2_EXCEPTION_TYPE_WRONG_API_CALL_SEQUENCE = 4,
	RS2_EXCEPTION_TYPE_NOT_IMPLEMENTED = 5,
	RS2_EXCEPTION_TYPE_DEVICE_IN_RECOVERY_MODE = 6,
	RS2_EXCEPTION_TYPE_IO = 7,
	RS2_EXCEPTION_TYPE_COUNT = 8,
)

@cenum(rs2_distortion,
	RS2_DISTORTION_NONE = 0,
	RS2_DISTORTION_MODIFIED_BROWN_CONRADY = 1,
	RS2_DISTORTION_INVERSE_BROWN_CONRADY = 2,
	RS2_DISTORTION_FTHETA = 3,
	RS2_DISTORTION_BROWN_CONRADY = 4,
	RS2_DISTORTION_COUNT = 5,
)

struct rs2_intrinsics
    width::Cint
    height::Cint
    ppx::Cfloat
    ppy::Cfloat
    fx::Cfloat
    fy::Cfloat
    model::rs2_distortion
    coeffs::NTuple{5, Cfloat}
end

struct rs2_motion_device_intrinsic
    data::NTuple{3, NTuple{4, Cfloat}}
    noise_variances::NTuple{3, Cfloat}
    bias_variances::NTuple{3, Cfloat}
end

@cenum(rs2_log_severity,
	RS2_LOG_SEVERITY_DEBUG = 0,
	RS2_LOG_SEVERITY_INFO = 1,
	RS2_LOG_SEVERITY_WARN = 2,
	RS2_LOG_SEVERITY_ERROR = 3,
	RS2_LOG_SEVERITY_FATAL = 4,
	RS2_LOG_SEVERITY_NONE = 5,
	RS2_LOG_SEVERITY_COUNT = 6,
)

@cenum(rs2_extension,
	RS2_EXTENSION_UNKNOWN = 0,
	RS2_EXTENSION_DEBUG = 1,
	RS2_EXTENSION_INFO = 2,
	RS2_EXTENSION_MOTION = 3,
	RS2_EXTENSION_OPTIONS = 4,
	RS2_EXTENSION_VIDEO = 5,
	RS2_EXTENSION_ROI = 6,
	RS2_EXTENSION_DEPTH_SENSOR = 7,
	RS2_EXTENSION_VIDEO_FRAME = 8,
	RS2_EXTENSION_MOTION_FRAME = 9,
	RS2_EXTENSION_COMPOSITE_FRAME = 10,
	RS2_EXTENSION_POINTS = 11,
	RS2_EXTENSION_DEPTH_FRAME = 12,
	RS2_EXTENSION_ADVANCED_MODE = 13,
	RS2_EXTENSION_RECORD = 14,
	RS2_EXTENSION_VIDEO_PROFILE = 15,
	RS2_EXTENSION_PLAYBACK = 16,
	RS2_EXTENSION_DEPTH_STEREO_SENSOR = 17,
	RS2_EXTENSION_DISPARITY_FRAME = 18,
	RS2_EXTENSION_MOTION_PROFILE = 19,
	RS2_EXTENSION_POSE_FRAME = 20,
	RS2_EXTENSION_POSE_PROFILE = 21,
	RS2_EXTENSION_TM2 = 22,
	RS2_EXTENSION_SOFTWARE_DEVICE = 23,
	RS2_EXTENSION_SOFTWARE_SENSOR = 24,
	RS2_EXTENSION_COUNT = 25,
)

@cenum(rs2_matchers,
	RS2_MATCHER_DI = 0,
	RS2_MATCHER_DI_C = 1,
	RS2_MATCHER_DLR_C = 2,
	RS2_MATCHER_DLR = 3,
	RS2_MATCHER_DEFAULT = 4,
	RS2_MATCHER_COUNT = 5,
)

const rs2_device_info = Void
const rs2_device = Void
const rs2_error = Void
const rs2_raw_data_buffer = Void
const rs2_frame = Void
const rs2_frame_queue = Void
const rs2_pipeline = Void
const rs2_pipeline_profile = Void
const rs2_config = Void
const rs2_device_list = Void
const rs2_stream_profile_list = Void
const rs2_stream_profile = Void
const rs2_frame_callback = Void
const rs2_log_callback = Void
const rs2_syncer = Void
const rs2_device_serializer = Void
const rs2_source = Void
const rs2_processing_block = Void
const rs2_frame_processor_callback = Void
const rs2_playback_status_changed_callback = Void
const rs2_context = Void
const rs2_device_hub = Void
const rs2_sensor_list = Void
const rs2_sensor = Void
const rs2_options = Void
const rs2_devices_changed_callback = Void
const rs2_notification = Void
const rs2_notifications_callback = Void

const rs2_notification_callback_ptr = Ptr{Void}
const rs2_devices_changed_callback_ptr = Ptr{Void}
const rs2_frame_callback_ptr = Ptr{Void}
const rs2_frame_processor_callback_ptr = Ptr{Void}
const rs2_time_t = Cdouble
const rs2_metadata_type = Clonglong
const RS2_API_MAJOR_VERSION = 2
const RS2_API_MINOR_VERSION = 10
const RS2_API_PATCH_VERSION = 2
const RS2_API_BUILD_VERSION = 0

# Skipping MacroDefinition: STRINGIFY ( arg ) # arg
# Skipping MacroDefinition: VAR_ARG_STRING ( arg ) STRINGIFY ( arg )
# Skipping MacroDefinition: RS2_API_VERSION ( ( ( RS2_API_MAJOR_VERSION ) * 10000 ) + ( ( RS2_API_MINOR_VERSION ) * 100 ) + ( RS2_API_PATCH_VERSION ) )
# Skipping MacroDefinition: RS2_API_VERSION_STR ( VAR_ARG_STRING ( RS2_API_MAJOR_VERSION . RS2_API_MINOR_VERSION . RS2_API_PATCH_VERSION ) )

const RS2_API_VERSION = RS2_API_MAJOR_VERSION * 10000 + RS2_API_MINOR_VERSION * 100 + RS2_API_PATCH_VERSION
const RS2_API_VERSION_STR = "$(RS2_API_MAJOR_VERSION).$(RS2_API_MINOR_VERSION).$(RS2_API_PATCH_VERSION)"

@cenum(rs2_recording_mode,
	RS2_RECORDING_MODE_BLANK_FRAMES = 0,
	RS2_RECORDING_MODE_COMPRESSED = 1,
	RS2_RECORDING_MODE_BEST_QUALITY = 2,
	RS2_RECORDING_MODE_COUNT = 3,
)

struct rs2_video_stream
    _type::rs2_stream
    index::Cint
    uid::Cint
    width::Cint
    height::Cint
    fps::Cint
    bpp::Cint
    fmt::rs2_format
    intrinsics::rs2_intrinsics
end

struct rs2_software_video_frame
    pixels::Ptr{Void}
    deleter::Ptr{Void}
    stride::Cint
    bpp::Cint
    timestamp::rs2_time_t
    domain::rs2_timestamp_domain
    frame_number::Cint
    profile::Ptr{rs2_stream_profile}
end
