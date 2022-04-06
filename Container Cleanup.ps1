$containers = docker ps -a
$containersnum = ($containers.count - 1)
$num = 1
while($num -lt $containers.Count){

$containerid = $containers[$num].Split("  ")[0]
$num = $num + 1
docker rm $containerid -f
}
