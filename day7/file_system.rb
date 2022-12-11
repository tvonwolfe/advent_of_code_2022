# frozen_string_literal: true

# a tree-like structure to represent a file system.
class FileSystem
  class FileNotFoundError < StandardError; end

  def initialize
    @root = Node.new(parent: nil, name: '/', size: nil)
    @nodes = [root]
    @current_directory = root
  end

  def create_file(filename, size, directory_name)
    directory_node = find_directory(directory_name)
    raise FileNotFoundError, "directory #{directory_name} not found" if directory_node.nil?

    new_node = directory_node.add_child(filename, size: size)
    nodes.push(new_node)

    new_node
  end

  def create_directory(directory_name, _parent_directory_name)
    directory_node = find_directory(directory_name)
    raise FileNotFoundError, "directory #{directory_name} not found" if directory_node.nil?

    new_node = directory_node.add_child(filename)
    nodes.push(new_node)

    new_node
  end

  # @param name [String] - name of directory to find
  # @return [Node] - the directory node
  def find_directory(name)
    directories.find { |dir| dir.name == name }
  end

  def find_file(name)
    files.find { |file| file.name == name }
  end

  def change_directory(name)
    current_directory = if name == '..'
                          current_directory.parent
                        else
                          find_or_create_directory(name)
                        end
  end

  private

  attr_reader :root, :nodes

  attr_accessor :current_directory

  # @return [Array<Node>] - array of directory nodes
  def directories
    nodes.select(&:directory?)
  end

  # @return [Array<Node>] - array of file nodes
  def files
    nodes.select(&:file?)
  end

  def find_or_create_directory(name)
    find_directory(name) || create_directory(name)
  end

  # a node in the file system.
  # can be a file or a directory that contains more files.
  class Node
    def initialize(parent:, name:, size:, children: [])
      @parent = parent
      @children = children
      @name = name
      @size = size
    end

    def add_child(name, size: nil)
      new_node = self.class.new(parent: self, name: name, size: size)
      children.push(new_node)

      new_node
    end

    def file?
      !size.nil?
    end

    def directory?
      !file?
    end

    private

    attr_reader :parent, :children, :name, :size
  end
end
