ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(TsundokuBuster.Repo, :manual)
Mox.defmock(ExTwitterMock, for: ExTwitter.Behaviour)
Mox.defmock(TsundokuBuster.Repository.UserMock, for: TsundokuBuster.Repository.UserBehaviour)
