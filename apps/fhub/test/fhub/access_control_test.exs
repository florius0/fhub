defmodule Fhub.AccessControlTest do
  use Fhub.DataCase

  alias Fhub.AccessControl

  describe "permissions" do
    alias Fhub.AccessControl.Permission

    @valid_attrs %{can: []}
    @update_attrs %{can: []}
    @invalid_attrs %{can: nil}

    def permission_fixture(attrs \\ %{}) do
      {:ok, permission} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AccessControl.create_permission()

      permission
    end

    test "list_permissions/0 returns all permissions" do
      permission = permission_fixture()
      assert AccessControl.list_permissions() == [permission]
    end

    test "get_permission!/1 returns the permission with given id" do
      permission = permission_fixture()
      assert AccessControl.get_permission!(permission.id) == permission
    end

    test "create_permission/1 with valid data creates a permission" do
      assert {:ok, %Permission{} = permission} = AccessControl.create_permission(@valid_attrs)
      assert permission.can == []
    end

    test "create_permission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AccessControl.create_permission(@invalid_attrs)
    end

    test "update_permission/2 with valid data updates the permission" do
      permission = permission_fixture()
      assert {:ok, %Permission{} = permission} = AccessControl.update_permission(permission, @update_attrs)
      assert permission.can == []
    end

    test "update_permission/2 with invalid data returns error changeset" do
      permission = permission_fixture()
      assert {:error, %Ecto.Changeset{}} = AccessControl.update_permission(permission, @invalid_attrs)
      assert permission == AccessControl.get_permission!(permission.id)
    end

    test "delete_permission/1 deletes the permission" do
      permission = permission_fixture()
      assert {:ok, %Permission{}} = AccessControl.delete_permission(permission)
      assert_raise Ecto.NoResultsError, fn -> AccessControl.get_permission!(permission.id) end
    end

    test "change_permission/1 returns a permission changeset" do
      permission = permission_fixture()
      assert %Ecto.Changeset{} = AccessControl.change_permission(permission)
    end
  end
end
