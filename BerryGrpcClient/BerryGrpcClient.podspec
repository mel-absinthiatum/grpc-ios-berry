Pod::Spec.new do |s|
  s.name     = 'BerryGrpcClient'
  s.version  = '0.0.1'
  s.license  = {
    :type => 'Apache License, Version 2.0',
    :text => <<-LICENSE
      Copyright 2020, mel-absinthiatum, mel.absinthiatum@gmail.com.
      All rights reserved.
      Redistribution and use in source and binary forms, with or without
      modification, are permitted provided that the following conditions are
      met:
          * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
          * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following disclaimer
      in the documentation and/or other materials provided with the
      distribution.
          * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived from
      this software without specific prior written permission.
      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
      A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
    LICENSE
  }
  s.authors  = { 'mel-absinthiatum' => 'mel.absinthiatum@gmail.com' }
  s.homepage = 'https://github.com/mel-absinthiatum/grpc-ios-berry'
  s.summary = 'gRPC client'
  s.source = { :git => 'https://github.com/mel-absinthiatum/grpc-ios-berry' }


  s.ios.deployment_target = '7.1'
  s.osx.deployment_target = '10.9'


  # Base directory where the .proto files are.
  src = '.'

  
  # We'll use protoc with the gRPC plugin.
  s.dependency '!ProtoCompiler-gRPCPlugin'


  # Pods directory corresponding to this app's Podfile, relative to the location of this podspec.
  pods_root = '../Pods'


  # Path where Cocoapods downloads protoc and the gRPC plugin.
  protoc_dir = "#{pods_root}/!ProtoCompiler"
  protoc = "#{protoc_dir}/protoc"
  plugin = "#{pods_root}/!ProtoCompiler-gRPCPlugin/grpc_objective_c_plugin"


  # Directory where you want the generated files to be placed. This is an example.
  dir = "."



# Since we switched to importing full path, -I needs to be set to the directory
  # from which the imported file can be found, which is the grpc's root here
  if ENV['FRAMEWORKS'] != 'NO' then
    s.user_target_xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'USE_FRAMEWORKS=1' }
    s.prepare_command = <<-CMD
    # Cannot find file if using *.proto. Maybe files' paths must match the -I flags
      #{protoc} \
          --plugin=protoc-gen-grpc=#{plugin} \
          --objc_out=. \
          --grpc_out=generate_for_named_framework=#{s.name}:. \
          --objc_opt=generate_for_named_framework=#{s.name} \
        -I #{src} \
        -I #{protoc_dir} \
        #{src}/*.proto &&
        echo "grpc files generation 1"
    CMD
  else
    s.prepare_command = <<-CMD
    mkdir -p #{dir}
    #{protoc} \
        --plugin=protoc-gen-grpc=#{plugin} \
        --objc_out=#{dir} \
        --grpc_out=#{dir} \
        -I #{src} \
        -I #{protoc_dir} \
        #{src}/*.proto &&
        echo "grpc files generation 2"
    CMD
  end





  # The --objc_out plugin generates a pair of .pbobjc.h/.pbobjc.m files for each .proto file.
  s.subspec 'Messages' do |ms|
    ms.source_files = "*.pbobjc.{h,m}"
    ms.header_mappings_dir = dir
    ms.requires_arc = false
    # The generated files depend on the protobuf runtime.
    ms.dependency 'Protobuf'
    ms.pod_target_xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1',
    }
  end


  # The --objcgrpc_out plugin generates a pair of .pbrpc.h/.pbrpc.m files for each .proto file with
  # a service defined.
  s.subspec 'Services' do |ss|
    ss.source_files = "*.pbrpc.{h,m}"
    ss.header_mappings_dir = dir
    ss.requires_arc = true
    # The generated files depend on the gRPC runtime, and on the files generated by `--objc_out`.
    ss.dependency 'gRPC-ProtoRPC'
    ss.dependency "#{s.name}/Messages"
  end

  s.pod_target_xcconfig = {
    'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1',
	  'USER_HEADER_SEARCH_PATHS' => '$SRCROOT/..'
  }
  #s.pod_target_xcconfig = {
    # This is needed by all pods that depend on Protobuf:
    #'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1',
    # This is needed by all pods that depend on gRPC-RxLibrary:
    #'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
  #}
end