class Station
  attr_reader :zone, :name

  def initialize(args)
    @zone = args.fetch(:zone)
    @name = args.fetch(:name)
  end
end
