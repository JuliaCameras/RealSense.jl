using RealSense

include("rs-utils.jl")

function get_sensor_option(sensor)
    err = Ref{Ptr{rs2_error}}(C_NULL)
    @info "Sensor supports the following options:"
    for i = 0:Int(RS2_OPTION_COUNT)-1
        option_type = rs2_option(i)
        result = rs2_supports_option(sensor, option_type, err)
        checkerror(err)
        if result > 0
            description = rs2_get_option_description(sensor, option_type, err)
            checkerror(err)
            value = rs2_get_option(sensor, option_type, err)
            checkerror(err)
            @info "    $i: $option_type: $(unsafe_string(description)) | value: $value"
        else
            @info "    $i: $option_type is not supported."
        end
    end
    @info "Select a option by index: "
    input = readline()
    idx = parse(Int, input)
    idx ≥ Int(RS2_OPTION_COUNT) && error("selected option index is out of range")
    return rs2_option(idx)
end

function change_sensor_option(sensor, option)
    err = Ref{Ptr{rs2_error}}(C_NULL)
    result = rs2_supports_option(sensor, option, err)
    checkerror(err)
    result == 0 && error("This option is not supported by this sensor")
    @info "Supported range for option $option:"
    minRef, maxRef, stepRef, defaultRef = Ref{Cfloat}(0), Ref{Cfloat}(0), Ref{Cfloat}(0), Ref{Cfloat}(0)
    rs2_get_option_range(sensor, option, minRef, maxRef, stepRef, defaultRef, err)
    checkerror(err)
    @info "  Min Value: $(minRef[])"
    @info "  Max Value: $(maxRef[])"
    @info "  Default Value: $(defaultRef[])"
    @info "  Step Value: $(stepRef[])"
    @info "Enter the new value for this option:"
    input = readline()
    newValue = parse(Cfloat, input)
    rs2_set_option(sensor, option, newValue, err)
    checkerror(err)
end

err = Ref{Ptr{rs2_error}}(C_NULL)
# create a context
ctx = rs2_create_context(RS2_API_VERSION, err)
checkerror(err)

device = get_a_realsense_device(ctx)
print_device_information(device)

sensor = get_a_sensor_from_a_device(device)

option = get_sensor_option(sensor)

change_sensor_option(sensor, option)
