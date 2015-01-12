#!/usr/local/bin/ruby

require 'mongo_agent'

a = MongoAgent::Agent.new({name: 'alignment_agent', queue: ENV["QUEUE"]})
existing = a.get_tasks({
  build: 'pf3D7_v2.1.5',
  reference: 'Pf3D7_v2.1.5.fasta.gz',
  raw_file: 'ERR022523_1.fastq.gz',
  agent_name: 'alignment_agent'
})

if existing.count > 1
  $stderr.puts "You may need to clear the db and restart the agents!"
  exit 1
end

if existing.count == 1
  existing_task = existing.first
  if existing_task[:ready]
    $stderr.puts "You may need to clear the db and restart the agents!"
    exit 1
  end
  if existing_task[:reference_ready]
    existing.update('$set' => {ready: true, raw_ready: true})
  else
    existing.update('$set' => {raw_ready: true})
  end
else
  a.db[a.queue].insert({
    build: 'pf3D7_v2.1.5',
    reference: 'Pf3D7_v2.1.5.fasta.gz',
    raw_file: 'ERR022523_1.fastq.gz',
    agent_name: 'alignment_agent',
    raw_ready: true
    })
end
exit
