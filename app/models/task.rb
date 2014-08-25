class Task < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    description :string
    timestamps
  end
  attr_accessible :description, :story, :story_id, :task_assignments, :users

  belongs_to :story, :inverse_of => :tasks, :counter_cache => true
  
  has_many :task_assignments, :dependent => :destroy, :inverse_of => :task
  has_many :users, :through => :task_assignments, :accessible => true, :dependent => :destroy

  acts_as_list :scope => :story

  # --- Permissions --- #

  def create_permitted?
    story.creatable_by?(acting_user)
  end

  def update_permitted?
    story.updatable_by?(acting_user)
  end

  def destroy_permitted?
    astory.destroyable_by?(acting_user)
  end

  def view_permitted?(field)
    story.viewable_by?(acting_user)
  end

end
