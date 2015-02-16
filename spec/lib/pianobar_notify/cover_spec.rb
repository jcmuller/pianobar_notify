require 'yaml'

RSpec.describe PianobarNotify::Cover do
  let(:blob_yaml) { YAML.load_file(File.join("spec", "support", "blob.yml")) }
  let(:blob) { PianobarNotify::Blob.send(:new, blob_yaml) }

  before do
    allow(subject).to receive(:blob).and_return(blob)
  end

  describe "image_name" do
    its(:image_name) { should eq "Some Artist - Some Album.png" }

    context "with funky stuff" do
      before { allow(blob).to receive(:artist).and_return("B & W & F / D . blah ? w") }

      its(:image_name) { should eq "B  W  F  D  blah  w - Some Album.png" }
    end
  end
end
