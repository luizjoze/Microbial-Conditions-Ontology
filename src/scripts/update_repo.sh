echo "This (experimental) update script will create a new repo according to your config file. It will:" 
echo "(1) overwrite your repositories Makefile, ODK sparql queries (your custom queries wont be touched) and docker wrapper (run.sh)."
echo "(2) and add missing files, if any."

set -e

OID=mco
SRCDIR=../
CONFIG=$OID"-odk.yaml"

rm -rf target
mkdir target
/tools/odk.py seed -c -g False -C $CONFIG
ls -l target/$OID/src
ls -l $SRCDIR
rsync -r -u --ignore-existing --exclude 'patterns/data/default/example.tsv' --exclude 'patterns/dosdp-patterns/example.yaml' target/$OID/src/ $SRCDIR
cp target/$OID/src/scripts/update_repo.sh $SRCDIR/scripts/
cp target/$OID/src/ontology/Makefile $SRCDIR/ontology/
cp target/$OID/src/ontology/run.sh $SRCDIR/ontology/
cp -r target/$OID/src/sparql/* $SRCDIR/sparql/
echo "WARNING: These files should be manually migrated: .gitignore, src/ontology/catalog.xml (if you added a new import or component)"
echo "Update successfully completed."