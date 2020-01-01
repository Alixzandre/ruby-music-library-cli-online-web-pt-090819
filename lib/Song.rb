class Song 
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre
  @@all =[]
  
  def initialize(name,artist = nil,genre = nil)
    @name = name
    self.artist= artist if artist!=nil
    self.genre = genre if genre!=nil
  end
  
  def artist= (artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre= (genre)
    @genre = genre
    genre.add_song(self)
  end
  
  def save 
    @@all << self
  end
  
  def self.all 
    @@all
  end
  
  def self.destroy_all 
    @@all.clear
  end
  
  def self.create(name)
    song = self.new(name)
    song.save
    song
  end
  
  def self.new_from_filename(name)
     song_name = name.split(" - ")[1]
    artist_name = name.split(" - ")[0]
    genre_name = name.split(" - ")[2].chomp(".mp3")
    
    song = self.find_or_create_by_name(song_name)
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre_name)
    song
  end
  
  def self.create_from_filename(name)
    @@all << self.new_from_filename(name)
  end
end