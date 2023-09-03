/// <summary>
/// This setup table is used to enable or disable the Fantastic Feature.
/// </summary>
table 50101 "Fantastic Feature Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Key"; Code[10])
        {
            Caption = 'Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Enabled"; Boolean)
        {
            Caption = 'Enabled';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Key")
        {
            Clustered = true;
        }
    }

}