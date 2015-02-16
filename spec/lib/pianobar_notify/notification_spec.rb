require 'yaml'

RSpec.describe PianobarNotify::Notification do
  let(:blob_yaml) { YAML.load_file(File.join("spec", "support", "blob.yml")) }
  let(:blob) { PianobarNotify::Blob.send(:new, blob_yaml) }

  before do
    allow(subject).to receive(:blob).and_return(blob)
    allow(blob).to receive(:thumbs_up?).and_return(true)
  end

  describe "summary" do
    its(:summary) { should eq "Pianobar - Playing" }
  end

  describe "body" do
    its(:body) { should eq(<<-EOF) }
Some Title
By Some Artist
<i>On: Some Album</i>
<i>Station: Some Station Radio</i>
Thumbs Up
EOF
  end
end
