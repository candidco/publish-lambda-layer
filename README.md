# publish-lambda-layer github action

This action takes a requirements.txt file, creates a .zip package with python dependencies and publishes to AWS as a lambda layer.

## **Inputs**

### `aws-access-key-id`

**Required** AWS access key id. Default `true`.

### `aws-secret-access-key`

**Required** AWS secret access key. Default `true`.

### `aws-default-region`

**Optional** AWS default region. Default `'us-east-1'`.

### `working-directory`

**Optional** The relative path of a directory containing the requirements.txt. Default `"./"`.

### `layer-name`

**Required** The name of the layer. Default `''`.

### `python-runtime`

**Optional** The compatible python runtime. Default `'python3.9'`.

### `additional-python-runtimes`

**Optional** A space-delimited list of additional compatible python runtimes, e.g.: python3.7 python3.6. Default `''`.


## **Outputs**

### `output`

The output of aws lambda publish-layer-version in compact JSON format (https://docs.aws.amazon.com/cli/latest/reference/lambda/publish-layer-version.html#output)

## **Example usage**

```yaml
- name: Publish lambda layer
  uses: candidco/publish-lambda-layer
  with:
    layer-name: my-lambda-layer
    aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
    aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```
