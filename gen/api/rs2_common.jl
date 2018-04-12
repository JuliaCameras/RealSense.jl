# Automatically generated using Clang.jl wrap_c, version 0.0.0

using Compat

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

# begin enum rs2_timestamp_domain
const rs2_timestamp_domain = UInt32
const RS2_TIMESTAMP_DOMAIN_HARDWARE_CLOCK = (UInt32)(0)
const RS2_TIMESTAMP_DOMAIN_SYSTEM_TIME = (UInt32)(1)
const RS2_TIMESTAMP_DOMAIN_COUNT = (UInt32)(2)
# end enum rs2_timestamp_domain

# begin enum rs2_frame_metadata_value
const rs2_frame_metadata_value = UInt32
const RS2_FRAME_METADATA_FRAME_COUNTER = (UInt32)(0)
const RS2_FRAME_METADATA_FRAME_TIMESTAMP = (UInt32)(1)
const RS2_FRAME_METADATA_SENSOR_TIMESTAMP = (UInt32)(2)
const RS2_FRAME_METADATA_ACTUAL_EXPOSURE = (UInt32)(3)
const RS2_FRAME_METADATA_GAIN_LEVEL = (UInt32)(4)
const RS2_FRAME_METADATA_AUTO_EXPOSURE = (UInt32)(5)
const RS2_FRAME_METADATA_WHITE_BALANCE = (UInt32)(6)
const RS2_FRAME_METADATA_TIME_OF_ARRIVAL = (UInt32)(7)
const RS2_FRAME_METADATA_TEMPERATURE = (UInt32)(8)
const RS2_FRAME_METADATA_BACKEND_TIMESTAMP = (UInt32)(9)
const RS2_FRAME_METADATA_ACTUAL_FPS = (UInt32)(10)
const RS2_FRAME_METADATA_COUNT = (UInt32)(11)
# end enum rs2_frame_metadata_value

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

# begin enum rs2_option
const rs2_option = UInt32
const RS2_OPTION_BACKLIGHT_COMPENSATION = (UInt32)(0)
const RS2_OPTION_BRIGHTNESS = (UInt32)(1)
const RS2_OPTION_CONTRAST = (UInt32)(2)
const RS2_OPTION_EXPOSURE = (UInt32)(3)
const RS2_OPTION_GAIN = (UInt32)(4)
const RS2_OPTION_GAMMA = (UInt32)(5)
const RS2_OPTION_HUE = (UInt32)(6)
const RS2_OPTION_SATURATION = (UInt32)(7)
const RS2_OPTION_SHARPNESS = (UInt32)(8)
const RS2_OPTION_WHITE_BALANCE = (UInt32)(9)
const RS2_OPTION_ENABLE_AUTO_EXPOSURE = (UInt32)(10)
const RS2_OPTION_ENABLE_AUTO_WHITE_BALANCE = (UInt32)(11)
const RS2_OPTION_VISUAL_PRESET = (UInt32)(12)
const RS2_OPTION_LASER_POWER = (UInt32)(13)
const RS2_OPTION_ACCURACY = (UInt32)(14)
const RS2_OPTION_MOTION_RANGE = (UInt32)(15)
const RS2_OPTION_FILTER_OPTION = (UInt32)(16)
const RS2_OPTION_CONFIDENCE_THRESHOLD = (UInt32)(17)
const RS2_OPTION_EMITTER_ENABLED = (UInt32)(18)
const RS2_OPTION_FRAMES_QUEUE_SIZE = (UInt32)(19)
const RS2_OPTION_TOTAL_FRAME_DROPS = (UInt32)(20)
const RS2_OPTION_AUTO_EXPOSURE_MODE = (UInt32)(21)
const RS2_OPTION_POWER_LINE_FREQUENCY = (UInt32)(22)
const RS2_OPTION_ASIC_TEMPERATURE = (UInt32)(23)
const RS2_OPTION_ERROR_POLLING_ENABLED = (UInt32)(24)
const RS2_OPTION_PROJECTOR_TEMPERATURE = (UInt32)(25)
const RS2_OPTION_OUTPUT_TRIGGER_ENABLED = (UInt32)(26)
const RS2_OPTION_MOTION_MODULE_TEMPERATURE = (UInt32)(27)
const RS2_OPTION_DEPTH_UNITS = (UInt32)(28)
const RS2_OPTION_ENABLE_MOTION_CORRECTION = (UInt32)(29)
const RS2_OPTION_AUTO_EXPOSURE_PRIORITY = (UInt32)(30)
const RS2_OPTION_COLOR_SCHEME = (UInt32)(31)
const RS2_OPTION_HISTOGRAM_EQUALIZATION_ENABLED = (UInt32)(32)
const RS2_OPTION_MIN_DISTANCE = (UInt32)(33)
const RS2_OPTION_MAX_DISTANCE = (UInt32)(34)
const RS2_OPTION_TEXTURE_SOURCE = (UInt32)(35)
const RS2_OPTION_FILTER_MAGNITUDE = (UInt32)(36)
const RS2_OPTION_FILTER_SMOOTH_ALPHA = (UInt32)(37)
const RS2_OPTION_FILTER_SMOOTH_DELTA = (UInt32)(38)
const RS2_OPTION_HOLES_FILL = (UInt32)(39)
const RS2_OPTION_STEREO_BASELINE = (UInt32)(40)
const RS2_OPTION_AUTO_EXPOSURE_CONVERGE_STEP = (UInt32)(41)
const RS2_OPTION_COUNT = (UInt32)(42)
# end enum rs2_option

# begin enum rs2_sr300_visual_preset
const rs2_sr300_visual_preset = UInt32
const RS2_SR300_VISUAL_PRESET_SHORT_RANGE = (UInt32)(0)
const RS2_SR300_VISUAL_PRESET_LONG_RANGE = (UInt32)(1)
const RS2_SR300_VISUAL_PRESET_BACKGROUND_SEGMENTATION = (UInt32)(2)
const RS2_SR300_VISUAL_PRESET_GESTURE_RECOGNITION = (UInt32)(3)
const RS2_SR300_VISUAL_PRESET_OBJECT_SCANNING = (UInt32)(4)
const RS2_SR300_VISUAL_PRESET_FACE_ANALYTICS = (UInt32)(5)
const RS2_SR300_VISUAL_PRESET_FACE_LOGIN = (UInt32)(6)
const RS2_SR300_VISUAL_PRESET_GR_CURSOR = (UInt32)(7)
const RS2_SR300_VISUAL_PRESET_DEFAULT = (UInt32)(8)
const RS2_SR300_VISUAL_PRESET_MID_RANGE = (UInt32)(9)
const RS2_SR300_VISUAL_PRESET_IR_ONLY = (UInt32)(10)
const RS2_SR300_VISUAL_PRESET_COUNT = (UInt32)(11)
# end enum rs2_sr300_visual_preset

# begin enum rs2_rs400_visual_preset
const rs2_rs400_visual_preset = UInt32
const RS2_RS400_VISUAL_PRESET_CUSTOM = (UInt32)(0)
const RS2_RS400_VISUAL_PRESET_DEFAULT = (UInt32)(1)
const RS2_RS400_VISUAL_PRESET_HAND = (UInt32)(2)
const RS2_RS400_VISUAL_PRESET_HIGH_ACCURACY = (UInt32)(3)
const RS2_RS400_VISUAL_PRESET_HIGH_DENSITY = (UInt32)(4)
const RS2_RS400_VISUAL_PRESET_MEDIUM_DENSITY = (UInt32)(5)
const RS2_RS400_VISUAL_PRESET_COUNT = (UInt32)(6)
# end enum rs2_rs400_visual_preset

# begin enum rs2_playback_status
const rs2_playback_status = UInt32
const RS2_PLAYBACK_STATUS_UNKNOWN = (UInt32)(0)
const RS2_PLAYBACK_STATUS_PLAYING = (UInt32)(1)
const RS2_PLAYBACK_STATUS_PAUSED = (UInt32)(2)
const RS2_PLAYBACK_STATUS_STOPPED = (UInt32)(3)
const RS2_PLAYBACK_STATUS_COUNT = (UInt32)(4)
# end enum rs2_playback_status

const rs2_playback_status_changed_callback_ptr = Ptr{Void}

# begin enum rs2_camera_info
const rs2_camera_info = UInt32
const RS2_CAMERA_INFO_NAME = (UInt32)(0)
const RS2_CAMERA_INFO_SERIAL_NUMBER = (UInt32)(1)
const RS2_CAMERA_INFO_FIRMWARE_VERSION = (UInt32)(2)
const RS2_CAMERA_INFO_PHYSICAL_PORT = (UInt32)(3)
const RS2_CAMERA_INFO_DEBUG_OP_CODE = (UInt32)(4)
const RS2_CAMERA_INFO_ADVANCED_MODE = (UInt32)(5)
const RS2_CAMERA_INFO_PRODUCT_ID = (UInt32)(6)
const RS2_CAMERA_INFO_CAMERA_LOCKED = (UInt32)(7)
const RS2_CAMERA_INFO_COUNT = (UInt32)(8)
# end enum rs2_camera_info

# begin enum rs2_stream
const rs2_stream = UInt32
const RS2_STREAM_ANY = (UInt32)(0)
const RS2_STREAM_DEPTH = (UInt32)(1)
const RS2_STREAM_COLOR = (UInt32)(2)
const RS2_STREAM_INFRARED = (UInt32)(3)
const RS2_STREAM_FISHEYE = (UInt32)(4)
const RS2_STREAM_GYRO = (UInt32)(5)
const RS2_STREAM_ACCEL = (UInt32)(6)
const RS2_STREAM_GPIO = (UInt32)(7)
const RS2_STREAM_POSE = (UInt32)(8)
const RS2_STREAM_COUNT = (UInt32)(9)
# end enum rs2_stream

# begin enum rs2_format
const rs2_format = UInt32
const RS2_FORMAT_ANY = (UInt32)(0)
const RS2_FORMAT_Z16 = (UInt32)(1)
const RS2_FORMAT_DISPARITY16 = (UInt32)(2)
const RS2_FORMAT_XYZ32F = (UInt32)(3)
const RS2_FORMAT_YUYV = (UInt32)(4)
const RS2_FORMAT_RGB8 = (UInt32)(5)
const RS2_FORMAT_BGR8 = (UInt32)(6)
const RS2_FORMAT_RGBA8 = (UInt32)(7)
const RS2_FORMAT_BGRA8 = (UInt32)(8)
const RS2_FORMAT_Y8 = (UInt32)(9)
const RS2_FORMAT_Y16 = (UInt32)(10)
const RS2_FORMAT_RAW10 = (UInt32)(11)
const RS2_FORMAT_RAW16 = (UInt32)(12)
const RS2_FORMAT_RAW8 = (UInt32)(13)
const RS2_FORMAT_UYVY = (UInt32)(14)
const RS2_FORMAT_MOTION_RAW = (UInt32)(15)
const RS2_FORMAT_MOTION_XYZ32F = (UInt32)(16)
const RS2_FORMAT_GPIO_RAW = (UInt32)(17)
const RS2_FORMAT_6DOF = (UInt32)(18)
const RS2_FORMAT_DISPARITY32 = (UInt32)(19)
const RS2_FORMAT_COUNT = (UInt32)(20)
# end enum rs2_format

struct rs2_extrinsics
    rotation::NTuple{9, Cfloat}
    translation::NTuple{3, Cfloat}
end

# begin enum rs2_notification_category
const rs2_notification_category = UInt32
const RS2_NOTIFICATION_CATEGORY_FRAMES_TIMEOUT = (UInt32)(0)
const RS2_NOTIFICATION_CATEGORY_FRAME_CORRUPTED = (UInt32)(1)
const RS2_NOTIFICATION_CATEGORY_HARDWARE_ERROR = (UInt32)(2)
const RS2_NOTIFICATION_CATEGORY_HARDWARE_EVENT = (UInt32)(3)
const RS2_NOTIFICATION_CATEGORY_UNKNOWN_ERROR = (UInt32)(4)
const RS2_NOTIFICATION_CATEGORY_COUNT = (UInt32)(5)
# end enum rs2_notification_category

# begin enum rs2_exception_type
const rs2_exception_type = UInt32
const RS2_EXCEPTION_TYPE_UNKNOWN = (UInt32)(0)
const RS2_EXCEPTION_TYPE_CAMERA_DISCONNECTED = (UInt32)(1)
const RS2_EXCEPTION_TYPE_BACKEND = (UInt32)(2)
const RS2_EXCEPTION_TYPE_INVALID_VALUE = (UInt32)(3)
const RS2_EXCEPTION_TYPE_WRONG_API_CALL_SEQUENCE = (UInt32)(4)
const RS2_EXCEPTION_TYPE_NOT_IMPLEMENTED = (UInt32)(5)
const RS2_EXCEPTION_TYPE_DEVICE_IN_RECOVERY_MODE = (UInt32)(6)
const RS2_EXCEPTION_TYPE_IO = (UInt32)(7)
const RS2_EXCEPTION_TYPE_COUNT = (UInt32)(8)
# end enum rs2_exception_type

# begin enum rs2_distortion
const rs2_distortion = UInt32
const RS2_DISTORTION_NONE = (UInt32)(0)
const RS2_DISTORTION_MODIFIED_BROWN_CONRADY = (UInt32)(1)
const RS2_DISTORTION_INVERSE_BROWN_CONRADY = (UInt32)(2)
const RS2_DISTORTION_FTHETA = (UInt32)(3)
const RS2_DISTORTION_BROWN_CONRADY = (UInt32)(4)
const RS2_DISTORTION_COUNT = (UInt32)(5)
# end enum rs2_distortion

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

# begin enum rs2_log_severity
const rs2_log_severity = UInt32
const RS2_LOG_SEVERITY_DEBUG = (UInt32)(0)
const RS2_LOG_SEVERITY_INFO = (UInt32)(1)
const RS2_LOG_SEVERITY_WARN = (UInt32)(2)
const RS2_LOG_SEVERITY_ERROR = (UInt32)(3)
const RS2_LOG_SEVERITY_FATAL = (UInt32)(4)
const RS2_LOG_SEVERITY_NONE = (UInt32)(5)
const RS2_LOG_SEVERITY_COUNT = (UInt32)(6)
# end enum rs2_log_severity

# begin enum rs2_extension
const rs2_extension = UInt32
const RS2_EXTENSION_UNKNOWN = (UInt32)(0)
const RS2_EXTENSION_DEBUG = (UInt32)(1)
const RS2_EXTENSION_INFO = (UInt32)(2)
const RS2_EXTENSION_MOTION = (UInt32)(3)
const RS2_EXTENSION_OPTIONS = (UInt32)(4)
const RS2_EXTENSION_VIDEO = (UInt32)(5)
const RS2_EXTENSION_ROI = (UInt32)(6)
const RS2_EXTENSION_DEPTH_SENSOR = (UInt32)(7)
const RS2_EXTENSION_VIDEO_FRAME = (UInt32)(8)
const RS2_EXTENSION_MOTION_FRAME = (UInt32)(9)
const RS2_EXTENSION_COMPOSITE_FRAME = (UInt32)(10)
const RS2_EXTENSION_POINTS = (UInt32)(11)
const RS2_EXTENSION_DEPTH_FRAME = (UInt32)(12)
const RS2_EXTENSION_ADVANCED_MODE = (UInt32)(13)
const RS2_EXTENSION_RECORD = (UInt32)(14)
const RS2_EXTENSION_VIDEO_PROFILE = (UInt32)(15)
const RS2_EXTENSION_PLAYBACK = (UInt32)(16)
const RS2_EXTENSION_DEPTH_STEREO_SENSOR = (UInt32)(17)
const RS2_EXTENSION_DISPARITY_FRAME = (UInt32)(18)
const RS2_EXTENSION_MOTION_PROFILE = (UInt32)(19)
const RS2_EXTENSION_POSE_FRAME = (UInt32)(20)
const RS2_EXTENSION_POSE_PROFILE = (UInt32)(21)
const RS2_EXTENSION_TM2 = (UInt32)(22)
const RS2_EXTENSION_SOFTWARE_DEVICE = (UInt32)(23)
const RS2_EXTENSION_SOFTWARE_SENSOR = (UInt32)(24)
const RS2_EXTENSION_COUNT = (UInt32)(25)
# end enum rs2_extension

# begin enum rs2_matchers
const rs2_matchers = UInt32
const RS2_MATCHER_DI = (UInt32)(0)
const RS2_MATCHER_DI_C = (UInt32)(1)
const RS2_MATCHER_DLR_C = (UInt32)(2)
const RS2_MATCHER_DLR = (UInt32)(3)
const RS2_MATCHER_DEFAULT = (UInt32)(4)
const RS2_MATCHER_COUNT = (UInt32)(5)
# end enum rs2_matchers

rs2_device_info = Void
rs2_device = Void
rs2_error = Void
rs2_raw_data_buffer = Void
rs2_frame = Void
rs2_frame_queue = Void
rs2_pipeline = Void
rs2_pipeline_profile = Void
rs2_config = Void
rs2_device_list = Void
rs2_stream_profile_list = Void
rs2_stream_profile = Void
rs2_frame_callback = Void
rs2_log_callback = Void
rs2_syncer = Void
rs2_device_serializer = Void
rs2_source = Void
rs2_processing_block = Void
rs2_frame_processor_callback = Void
rs2_playback_status_changed_callback = Void
rs2_context = Void
rs2_device_hub = Void
rs2_sensor_list = Void
rs2_sensor = Void
rs2_options = Void
rs2_devices_changed_callback = Void
rs2_notification = Void
rs2_notifications_callback = Void

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

# begin enum rs2_recording_mode
const rs2_recording_mode = UInt32
const RS2_RECORDING_MODE_BLANK_FRAMES = (UInt32)(0)
const RS2_RECORDING_MODE_COMPRESSED = (UInt32)(1)
const RS2_RECORDING_MODE_BEST_QUALITY = (UInt32)(2)
const RS2_RECORDING_MODE_COUNT = (UInt32)(3)
# end enum rs2_recording_mode

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
