import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties:
        AdditionalProperties(pubName: 'honar_api_v5', pubAuthor: 'Johnny depp'),
    inputSpecFile: 'lib/swaggers/swagger1.yaml',
    generatorName: Generator.dart,
    outputDirectory: 'api/')
class Example extends OpenapiGeneratorConfig {}
