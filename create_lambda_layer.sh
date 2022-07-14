#read arguments
while getopts p:r: flag; do
  case "${flag}" in
  p) python=${OPTARG} ;;
  r) requirements=${OPTARG} ;;
  esac
done

#check given arguments
if [ -z ${requirements+x} ]; then requirements="requirements.txt"; fi
if [ -z ${python+x} ]; then
  echo "python version is not set. please specify python version by using the -p flag (eg. -p python3.8)"
  exit 0
fi

#create temporary dir
CURR_DIR="$(pwd)"
TMP_DIR="$CURR_DIR/$(date +"%Y-%m-%d_%H-%M-%S")_$RANDOM"
mkdir $TMP_DIR
cp $requirements $TMP_DIR/requirements.txt
cd $TMP_DIR

#create lambda layer
docker run \
  --rm \
  --name lambda_layer \
  -v "$PWD":/var/task "public.ecr.aws/sam/build-$python" /bin/sh \
  -c "pip install -r requirements.txt -t python/lib/$python/site-packages/; exit" \
  && 
zip -r $CURR_DIR/lambda_layer.zip python >/dev/null

#cleanup
rm -rf $TMP_DIR
