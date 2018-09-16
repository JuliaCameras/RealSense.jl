# Automatically generated using Clang.jl wrap_c, version 0.0.0


const RS2_PRODUCT_LINE_ANY = Float32(0x0f)
const RS2_PRODUCT_LINE_ANY_INTEL = 0xfe
const RS2_PRODUCT_LINE_NON_INTEL = 0x01
const RS2_PRODUCT_LINE_D400 = 0x02
const RS2_PRODUCT_LINE_SR300 = 0x04

# begin enum rs2_timestamp_domain
const rs2_timestamp_domain = UInt32
const RS2_TIMESTAMP_DOMAIN_HARDWARE_CLOCK = 0 |> UInt32
const RS2_TIMESTAMP_DOMAIN_SYSTEM_TIME = 1 |> UInt32
const RS2_TIMESTAMP_DOMAIN_COUNT = 2 |> UInt32
# end enum rs2_timestamp_domain

# begin enum rs2_frame_metadata_value
const rs2_frame_metadata_value = UInt32
const RS2_FRAME_METADATA_FRAME_COUNTER = 0 |> UInt32
const RS2_FRAME_METADATA_FRAME_TIMESTAMP = 1 |> UInt32
const RS2_FRAME_METADATA_SENSOR_TIMESTAMP = 2 |> UInt32
const RS2_FRAME_METADATA_ACTUAL_EXPOSURE = 3 |> UInt32
const RS2_FRAME_METADATA_GAIN_LEVEL = 4 |> UInt32
const RS2_FRAME_METADATA_AUTO_EXPOSURE = 5 |> UInt32
const RS2_FRAME_METADATA_WHITE_BALANCE = 6 |> UInt32
const RS2_FRAME_METADATA_TIME_OF_ARRIVAL = 7 |> UInt32
const RS2_FRAME_METADATA_TEMPERATURE = 8 |> UInt32
const RS2_FRAME_METADATA_BACKEND_TIMESTAMP = 9 |> UInt32
const RS2_FRAME_METADATA_ACTUAL_FPS = 10 |> UInt32
const RS2_FRAME_METADATA_FRAME_LASER_POWER = 11 |> UInt32
const RS2_FRAME_METADATA_FRAME_LASER_POWER_MODE = 12 |> UInt32
const RS2_FRAME_METADATA_EXPOSURE_PRIORITY = 13 |> UInt32
const RS2_FRAME_METADATA_EXPOSURE_ROI_LEFT = 14 |> UInt32
const RS2_FRAME_METADATA_EXPOSURE_ROI_RIGHT = 15 |> UInt32
const RS2_FRAME_METADATA_EXPOSURE_ROI_TOP = 16 |> UInt32
const RS2_FRAME_METADATA_EXPOSURE_ROI_BOTTOM = 17 |> UInt32
const RS2_FRAME_METADATA_BRIGHTNESS = 18 |> UInt32
const RS2_FRAME_METADATA_CONTRAST = 19 |> UInt32
const RS2_FRAME_METADATA_SATURATION = 20 |> UInt32
const RS2_FRAME_METADATA_SHARPNESS = 21 |> UInt32
const RS2_FRAME_METADATA_AUTO_WHITE_BALANCE_TEMPERATURE = 22 |> UInt32
const RS2_FRAME_METADATA_BACKLIGHT_COMPENSATION = 23 |> UInt32
const RS2_FRAME_METADATA_HUE = 24 |> UInt32
const RS2_FRAME_METADATA_GAMMA = 25 |> UInt32
const RS2_FRAME_METADATA_MANUAL_WHITE_BALANCE = 26 |> UInt32
const RS2_FRAME_METADATA_POWER_LINE_FREQUENCY = 27 |> UInt32
const RS2_FRAME_METADATA_LOW_LIGHT_COMPENSATION = 28 |> UInt32
const RS2_FRAME_METADATA_COUNT = 29 |> UInt32
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
const RS2_OPTION_BACKLIGHT_COMPENSATION = 0 |> UInt32
const RS2_OPTION_BRIGHTNESS = 1 |> UInt32
const RS2_OPTION_CONTRAST = 2 |> UInt32
const RS2_OPTION_EXPOSURE = 3 |> UInt32
const RS2_OPTION_GAIN = 4 |> UInt32
const RS2_OPTION_GAMMA = 5 |> UInt32
const RS2_OPTION_HUE = 6 |> UInt32
const RS2_OPTION_SATURATION = 7 |> UInt32
const RS2_OPTION_SHARPNESS = 8 |> UInt32
const RS2_OPTION_WHITE_BALANCE = 9 |> UInt32
const RS2_OPTION_ENABLE_AUTO_EXPOSURE = 10 |> UInt32
const RS2_OPTION_ENABLE_AUTO_WHITE_BALANCE = 11 |> UInt32
const RS2_OPTION_VISUAL_PRESET = 12 |> UInt32
const RS2_OPTION_LASER_POWER = 13 |> UInt32
const RS2_OPTION_ACCURACY = 14 |> UInt32
const RS2_OPTION_MOTION_RANGE = 15 |> UInt32
const RS2_OPTION_FILTER_OPTION = 16 |> UInt32
const RS2_OPTION_CONFIDENCE_THRESHOLD = 17 |> UInt32
const RS2_OPTION_EMITTER_ENABLED = 18 |> UInt32
const RS2_OPTION_FRAMES_QUEUE_SIZE = 19 |> UInt32
const RS2_OPTION_TOTAL_FRAME_DROPS = 20 |> UInt32
const RS2_OPTION_AUTO_EXPOSURE_MODE = 21 |> UInt32
const RS2_OPTION_POWER_LINE_FREQUENCY = 22 |> UInt32
const RS2_OPTION_ASIC_TEMPERATURE = 23 |> UInt32
const RS2_OPTION_ERROR_POLLING_ENABLED = 24 |> UInt32
const RS2_OPTION_PROJECTOR_TEMPERATURE = 25 |> UInt32
const RS2_OPTION_OUTPUT_TRIGGER_ENABLED = 26 |> UInt32
const RS2_OPTION_MOTION_MODULE_TEMPERATURE = 27 |> UInt32
const RS2_OPTION_DEPTH_UNITS = 28 |> UInt32
const RS2_OPTION_ENABLE_MOTION_CORRECTION = 29 |> UInt32
const RS2_OPTION_AUTO_EXPOSURE_PRIORITY = 30 |> UInt32
const RS2_OPTION_COLOR_SCHEME = 31 |> UInt32
const RS2_OPTION_HISTOGRAM_EQUALIZATION_ENABLED = 32 |> UInt32
const RS2_OPTION_MIN_DISTANCE = 33 |> UInt32
const RS2_OPTION_MAX_DISTANCE = 34 |> UInt32
const RS2_OPTION_TEXTURE_SOURCE = 35 |> UInt32
const RS2_OPTION_FILTER_MAGNITUDE = 36 |> UInt32
const RS2_OPTION_FILTER_SMOOTH_ALPHA = 37 |> UInt32
const RS2_OPTION_FILTER_SMOOTH_DELTA = 38 |> UInt32
const RS2_OPTION_HOLES_FILL = 39 |> UInt32
const RS2_OPTION_STEREO_BASELINE = 40 |> UInt32
const RS2_OPTION_AUTO_EXPOSURE_CONVERGE_STEP = 41 |> UInt32
const RS2_OPTION_INTER_CAM_SYNC_MODE = 42 |> UInt32
const RS2_OPTION_COUNT = 43 |> UInt32
# end enum rs2_option

# begin enum rs2_sr300_visual_preset
const rs2_sr300_visual_preset = UInt32
const RS2_SR300_VISUAL_PRESET_SHORT_RANGE = 0 |> UInt32
const RS2_SR300_VISUAL_PRESET_LONG_RANGE = 1 |> UInt32
const RS2_SR300_VISUAL_PRESET_BACKGROUND_SEGMENTATION = 2 |> UInt32
const RS2_SR300_VISUAL_PRESET_GESTURE_RECOGNITION = 3 |> UInt32
const RS2_SR300_VISUAL_PRESET_OBJECT_SCANNING = 4 |> UInt32
const RS2_SR300_VISUAL_PRESET_FACE_ANALYTICS = 5 |> UInt32
const RS2_SR300_VISUAL_PRESET_FACE_LOGIN = 6 |> UInt32
const RS2_SR300_VISUAL_PRESET_GR_CURSOR = 7 |> UInt32
const RS2_SR300_VISUAL_PRESET_DEFAULT = 8 |> UInt32
const RS2_SR300_VISUAL_PRESET_MID_RANGE = 9 |> UInt32
const RS2_SR300_VISUAL_PRESET_IR_ONLY = 10 |> UInt32
const RS2_SR300_VISUAL_PRESET_COUNT = 11 |> UInt32
# end enum rs2_sr300_visual_preset

# begin enum rs2_rs400_visual_preset
const rs2_rs400_visual_preset = UInt32
const RS2_RS400_VISUAL_PRESET_CUSTOM = 0 |> UInt32
const RS2_RS400_VISUAL_PRESET_DEFAULT = 1 |> UInt32
const RS2_RS400_VISUAL_PRESET_HAND = 2 |> UInt32
const RS2_RS400_VISUAL_PRESET_HIGH_ACCURACY = 3 |> UInt32
const RS2_RS400_VISUAL_PRESET_HIGH_DENSITY = 4 |> UInt32
const RS2_RS400_VISUAL_PRESET_MEDIUM_DENSITY = 5 |> UInt32
const RS2_RS400_VISUAL_PRESET_REMOVE_IR_PATTERN = 6 |> UInt32
const RS2_RS400_VISUAL_PRESET_COUNT = 7 |> UInt32
# end enum rs2_rs400_visual_preset

# begin enum rs2_camera_info
const rs2_camera_info = UInt32
const RS2_CAMERA_INFO_NAME = 0 |> UInt32
const RS2_CAMERA_INFO_SERIAL_NUMBER = 1 |> UInt32
const RS2_CAMERA_INFO_FIRMWARE_VERSION = 2 |> UInt32
const RS2_CAMERA_INFO_RECOMMENDED_FIRMWARE_VERSION = 3 |> UInt32
const RS2_CAMERA_INFO_PHYSICAL_PORT = 4 |> UInt32
const RS2_CAMERA_INFO_DEBUG_OP_CODE = 5 |> UInt32
const RS2_CAMERA_INFO_ADVANCED_MODE = 6 |> UInt32
const RS2_CAMERA_INFO_PRODUCT_ID = 7 |> UInt32
const RS2_CAMERA_INFO_CAMERA_LOCKED = 8 |> UInt32
const RS2_CAMERA_INFO_USB_TYPE_DESCRIPTOR = 9 |> UInt32
const RS2_CAMERA_INFO_COUNT = 10 |> UInt32
# end enum rs2_camera_info

# begin enum rs2_stream
const rs2_stream = UInt32
const RS2_STREAM_ANY = 0 |> UInt32
const RS2_STREAM_DEPTH = 1 |> UInt32
const RS2_STREAM_COLOR = 2 |> UInt32
const RS2_STREAM_INFRARED = 3 |> UInt32
const RS2_STREAM_FISHEYE = 4 |> UInt32
const RS2_STREAM_GYRO = 5 |> UInt32
const RS2_STREAM_ACCEL = 6 |> UInt32
const RS2_STREAM_GPIO = 7 |> UInt32
const RS2_STREAM_POSE = 8 |> UInt32
const RS2_STREAM_CONFIDENCE = 9 |> UInt32
const RS2_STREAM_COUNT = 10 |> UInt32
# end enum rs2_stream

# begin enum rs2_format
const rs2_format = UInt32
const RS2_FORMAT_ANY = 0 |> UInt32
const RS2_FORMAT_Z16 = 1 |> UInt32
const RS2_FORMAT_DISPARITY16 = 2 |> UInt32
const RS2_FORMAT_XYZ32F = 3 |> UInt32
const RS2_FORMAT_YUYV = 4 |> UInt32
const RS2_FORMAT_RGB8 = 5 |> UInt32
const RS2_FORMAT_BGR8 = 6 |> UInt32
const RS2_FORMAT_RGBA8 = 7 |> UInt32
const RS2_FORMAT_BGRA8 = 8 |> UInt32
const RS2_FORMAT_Y8 = 9 |> UInt32
const RS2_FORMAT_Y16 = 10 |> UInt32
const RS2_FORMAT_RAW10 = 11 |> UInt32
const RS2_FORMAT_RAW16 = 12 |> UInt32
const RS2_FORMAT_RAW8 = 13 |> UInt32
const RS2_FORMAT_UYVY = 14 |> UInt32
const RS2_FORMAT_MOTION_RAW = 15 |> UInt32
const RS2_FORMAT_MOTION_XYZ32F = 16 |> UInt32
const RS2_FORMAT_GPIO_RAW = 17 |> UInt32
const RS2_FORMAT_6DOF = 18 |> UInt32
const RS2_FORMAT_DISPARITY32 = 19 |> UInt32
const RS2_FORMAT_COUNT = 20 |> UInt32
# end enum rs2_format

struct rs2_extrinsics
    rotation::NTuple{9, Cfloat}
    translation::NTuple{3, Cfloat}
end

# begin enum rs2_notification_category
const rs2_notification_category = UInt32
const RS2_NOTIFICATION_CATEGORY_FRAMES_TIMEOUT = 0 |> UInt32
const RS2_NOTIFICATION_CATEGORY_FRAME_CORRUPTED = 1 |> UInt32
const RS2_NOTIFICATION_CATEGORY_HARDWARE_ERROR = 2 |> UInt32
const RS2_NOTIFICATION_CATEGORY_HARDWARE_EVENT = 3 |> UInt32
const RS2_NOTIFICATION_CATEGORY_UNKNOWN_ERROR = 4 |> UInt32
const RS2_NOTIFICATION_CATEGORY_FIRMWARE_UPDATE_RECOMMENDED = 5 |> UInt32
const RS2_NOTIFICATION_CATEGORY_COUNT = 6 |> UInt32
# end enum rs2_notification_category

# begin enum rs2_exception_type
const rs2_exception_type = UInt32
const RS2_EXCEPTION_TYPE_UNKNOWN = 0 |> UInt32
const RS2_EXCEPTION_TYPE_CAMERA_DISCONNECTED = 1 |> UInt32
const RS2_EXCEPTION_TYPE_BACKEND = 2 |> UInt32
const RS2_EXCEPTION_TYPE_INVALID_VALUE = 3 |> UInt32
const RS2_EXCEPTION_TYPE_WRONG_API_CALL_SEQUENCE = 4 |> UInt32
const RS2_EXCEPTION_TYPE_NOT_IMPLEMENTED = 5 |> UInt32
const RS2_EXCEPTION_TYPE_DEVICE_IN_RECOVERY_MODE = 6 |> UInt32
const RS2_EXCEPTION_TYPE_IO = 7 |> UInt32
const RS2_EXCEPTION_TYPE_COUNT = 8 |> UInt32
# end enum rs2_exception_type

# begin enum rs2_distortion
const rs2_distortion = UInt32
const RS2_DISTORTION_NONE = 0 |> UInt32
const RS2_DISTORTION_MODIFIED_BROWN_CONRADY = 1 |> UInt32
const RS2_DISTORTION_INVERSE_BROWN_CONRADY = 2 |> UInt32
const RS2_DISTORTION_FTHETA = 3 |> UInt32
const RS2_DISTORTION_BROWN_CONRADY = 4 |> UInt32
const RS2_DISTORTION_COUNT = 5 |> UInt32
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
const RS2_LOG_SEVERITY_DEBUG = 0 |> UInt32
const RS2_LOG_SEVERITY_INFO = 1 |> UInt32
const RS2_LOG_SEVERITY_WARN = 2 |> UInt32
const RS2_LOG_SEVERITY_ERROR = 3 |> UInt32
const RS2_LOG_SEVERITY_FATAL = 4 |> UInt32
const RS2_LOG_SEVERITY_NONE = 5 |> UInt32
const RS2_LOG_SEVERITY_COUNT = 6 |> UInt32
# end enum rs2_log_severity

# begin enum rs2_extension
const rs2_extension = UInt32
const RS2_EXTENSION_UNKNOWN = 0 |> UInt32
const RS2_EXTENSION_DEBUG = 1 |> UInt32
const RS2_EXTENSION_INFO = 2 |> UInt32
const RS2_EXTENSION_MOTION = 3 |> UInt32
const RS2_EXTENSION_OPTIONS = 4 |> UInt32
const RS2_EXTENSION_VIDEO = 5 |> UInt32
const RS2_EXTENSION_ROI = 6 |> UInt32
const RS2_EXTENSION_DEPTH_SENSOR = 7 |> UInt32
const RS2_EXTENSION_VIDEO_FRAME = 8 |> UInt32
const RS2_EXTENSION_MOTION_FRAME = 9 |> UInt32
const RS2_EXTENSION_COMPOSITE_FRAME = 10 |> UInt32
const RS2_EXTENSION_POINTS = 11 |> UInt32
const RS2_EXTENSION_DEPTH_FRAME = 12 |> UInt32
const RS2_EXTENSION_ADVANCED_MODE = 13 |> UInt32
const RS2_EXTENSION_RECORD = 14 |> UInt32
const RS2_EXTENSION_VIDEO_PROFILE = 15 |> UInt32
const RS2_EXTENSION_PLAYBACK = 16 |> UInt32
const RS2_EXTENSION_DEPTH_STEREO_SENSOR = 17 |> UInt32
const RS2_EXTENSION_DISPARITY_FRAME = 18 |> UInt32
const RS2_EXTENSION_MOTION_PROFILE = 19 |> UInt32
const RS2_EXTENSION_POSE_FRAME = 20 |> UInt32
const RS2_EXTENSION_POSE_PROFILE = 21 |> UInt32
const RS2_EXTENSION_TM2 = 22 |> UInt32
const RS2_EXTENSION_SOFTWARE_DEVICE = 23 |> UInt32
const RS2_EXTENSION_SOFTWARE_SENSOR = 24 |> UInt32
const RS2_EXTENSION_COUNT = 25 |> UInt32
# end enum rs2_extension

# begin enum rs2_matchers
const rs2_matchers = UInt32
const RS2_MATCHER_DI = 0 |> UInt32
const RS2_MATCHER_DI_C = 1 |> UInt32
const RS2_MATCHER_DLR_C = 2 |> UInt32
const RS2_MATCHER_DLR = 3 |> UInt32
const RS2_MATCHER_DEFAULT = 4 |> UInt32
const RS2_MATCHER_COUNT = 5 |> UInt32
# end enum rs2_matchers

const rs2_device_info = Cvoid
const rs2_device = Cvoid
const rs2_error = Cvoid
const rs2_raw_data_buffer = Cvoid
const rs2_frame = Cvoid
const rs2_frame_queue = Cvoid
const rs2_pipeline = Cvoid
const rs2_pipeline_profile = Cvoid
const rs2_config = Cvoid
const rs2_device_list = Cvoid
const rs2_stream_profile_list = Cvoid
const rs2_stream_profile = Cvoid
const rs2_frame_callback = Cvoid
const rs2_log_callback = Cvoid
const rs2_syncer = Cvoid
const rs2_device_serializer = Cvoid
const rs2_source = Cvoid
const rs2_processing_block = Cvoid
const rs2_frame_processor_callback = Cvoid
const rs2_playback_status_changed_callback = Cvoid
const rs2_context = Cvoid
const rs2_device_hub = Cvoid
const rs2_sensor_list = Cvoid
const rs2_sensor = Cvoid
const rs2_options = Cvoid
const rs2_devices_changed_callback = Cvoid
const rs2_notification = Cvoid
const rs2_notifications_callback = Cvoid
const rs2_notification_callback_ptr = Ptr{Cvoid}
const rs2_devices_changed_callback_ptr = Ptr{Cvoid}
const rs2_frame_callback_ptr = Ptr{Cvoid}
const rs2_frame_processor_callback_ptr = Ptr{Cvoid}
const rs2_time_t = Cdouble
const rs2_metadata_type = Clonglong
const STDepthControlGroup = Cvoid
const STRsm = Cvoid
const STRauSupportVectorControl = Cvoid
const STColorControl = Cvoid
const STRauColorThresholdsControl = Cvoid
const STSloColorThresholdsControl = Cvoid
const STSloPenaltyControl = Cvoid
const STHdad = Cvoid
const STColorCorrection = Cvoid
const STAEControl = Cvoid
const STDepthTableControl = Cvoid
const STCensusRadius = Cvoid

# begin enum rs2_playback_status
const rs2_playback_status = UInt32
const RS2_PLAYBACK_STATUS_UNKNOWN = 0 |> UInt32
const RS2_PLAYBACK_STATUS_PLAYING = 1 |> UInt32
const RS2_PLAYBACK_STATUS_PAUSED = 2 |> UInt32
const RS2_PLAYBACK_STATUS_STOPPED = 3 |> UInt32
const RS2_PLAYBACK_STATUS_COUNT = 4 |> UInt32
# end enum rs2_playback_status

const rs2_playback_status_changed_callback_ptr = Ptr{Cvoid}
const RS2_API_MAJOR_VERSION = 2
const RS2_API_MINOR_VERSION = 15
const RS2_API_PATCH_VERSION = 0
const RS2_API_BUILD_VERSION = 0

# Skipping MacroDefinition: STRINGIFY ( arg ) # arg
# Skipping MacroDefinition: VAR_ARG_STRING ( arg ) STRINGIFY ( arg )
# Skipping MacroDefinition: RS2_API_VERSION ( ( ( RS2_API_MAJOR_VERSION ) * 10000 ) + ( ( RS2_API_MINOR_VERSION ) * 100 ) + ( RS2_API_PATCH_VERSION ) )
# Skipping MacroDefinition: RS2_API_VERSION_STR ( VAR_ARG_STRING ( RS2_API_MAJOR_VERSION . RS2_API_MINOR_VERSION . RS2_API_PATCH_VERSION ) )

# begin enum rs2_recording_mode
const rs2_recording_mode = UInt32
const RS2_RECORDING_MODE_BLANK_FRAMES = 0 |> UInt32
const RS2_RECORDING_MODE_COMPRESSED = 1 |> UInt32
const RS2_RECORDING_MODE_BEST_QUALITY = 2 |> UInt32
const RS2_RECORDING_MODE_COUNT = 3 |> UInt32
# end enum rs2_recording_mode

struct rs2_video_stream
    type::rs2_stream
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
    pixels::Ptr{Cvoid}
    deleter::Ptr{Cvoid}
    stride::Cint
    bpp::Cint
    timestamp::rs2_time_t
    domain::rs2_timestamp_domain
    frame_number::Cint
    profile::Ptr{rs2_stream_profile}
end
