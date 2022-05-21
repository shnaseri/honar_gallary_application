import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties:
        AdditionalProperties(pubName: 'petstore_api', pubAuthor: 'Johnny depp'),
    inputSpecFile: 'lib/swaggers/swagger1.yaml',
    generatorName: Generator.dart,
    outputDirectory: 'api/petstore_api')
class Example extends OpenapiGeneratorConfig {}
